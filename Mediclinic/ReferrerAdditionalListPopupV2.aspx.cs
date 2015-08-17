using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Text.RegularExpressions;
using System.Collections;

public partial class ReferrerAdditionalListPopupV2 : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
                Utilities.SetNoCache(Response);
            HideErrorMessage();
            Utilities.UpdatePageHeaderV2(Page.Master, true);

            if (!IsPostBack)
            {
                FillGrdReferrerAdditionalEmails();
            }
        }
        catch (CustomMessageException ex)
        {
            if (IsPostBack) SetErrorMessage(ex.Message);
            else HideTableAndSetErrorMessage(ex.Message);
        }
        catch (Exception ex)
        {
            if (IsPostBack) SetErrorMessage("", ex.ToString());
            else HideTableAndSetErrorMessage("", ex.ToString());
        }
    }

    #region IsValidFormPTID(), GetFormPTID()

    private bool IsValidFormPTID()
    {
        string id = Request.QueryString["pt"];
        return id != null && Regex.IsMatch(id, @"^\d+$");
    }
    private int GetFormPTID()
    {
        if (!IsValidFormPTID())
            throw new CustomMessageException("Invalid url pt id");

        string id = Request.QueryString["pt"];
        return Convert.ToInt32(id);
    }

    #endregion

    #region GrdReferrerAdditionalEmails

    protected void FillGrdReferrerAdditionalEmails()
    {
        try
        {
            Patient patient = PatientDB.GetByID(GetFormPTID());
            lblHeading.Text = "Referrer Additional Emails For " + patient.Person.FullnameWithoutMiddlename;


            DataTable dt = ReferrerAdditionalEmailDB.GetDataTable_ByPatient(patient.PatientID, false);
            dt.DefaultView.Sort = "rae_name ASC";
            dt = dt.DefaultView.ToTable();

            ViewState["referreradditionalemail_data"] = dt;


            if (dt.Rows.Count > 0)
            {
                if (IsPostBack && ViewState["referreradditionalemail_sortexpression"] != null && ViewState["referreradditionalemail_sortexpression"].ToString().Length > 0)
                {
                    DataView dataView = new DataView(dt);
                    dataView.Sort = ViewState["referreradditionalemail_sortexpression"].ToString();
                    GrdReferrerAdditionalEmails.DataSource = dataView;
                }
                else
                {
                    GrdReferrerAdditionalEmails.DataSource = dt;
                }


                GrdReferrerAdditionalEmails.DataBind();

            }
            else
            {
                dt.Rows.Add(dt.NewRow());
                GrdReferrerAdditionalEmails.DataSource = dt;
                GrdReferrerAdditionalEmails.DataBind();

                int TotalColumns = GrdReferrerAdditionalEmails.Rows[0].Cells.Count;
                GrdReferrerAdditionalEmails.Rows[0].Cells.Clear();
                GrdReferrerAdditionalEmails.Rows[0].Cells.Add(new TableCell());
                GrdReferrerAdditionalEmails.Rows[0].Cells[0].ColumnSpan = TotalColumns;
                GrdReferrerAdditionalEmails.Rows[0].Cells[0].Text = "No Additional Emails Added Yet";
            }
        }
        catch (CustomMessageException ex)
        {
            SetErrorMessage(ex.ToString());
        }
        catch (Exception ex)
        {
            SetErrorMessage("", Utilities.IsDev() ? ex.ToString() : ex.Message);
        }

    }
    protected void GrdReferrerAdditionalEmails_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.Pager)
        {
            //if (!Utilities.IsDev())
                e.Row.Cells[0].CssClass = "hiddencol";
        }
    }
    protected void GrdReferrerAdditionalEmails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Patient patient = PatientDB.GetByID(GetFormPTID());
        if (patient == null)
        {
            HideTableAndSetErrorMessage("");
            return;
        }

        UserView userView = UserView.GetInstance();

        DataTable dt = ViewState["referreradditionalemail_data"] as DataTable;
        bool tblEmpty = (dt.Rows.Count == 1 && dt.Rows[0][0] == DBNull.Value);
        if (!tblEmpty && e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblId = (Label)e.Row.FindControl("lblId");
            DataRow[] foundRows = dt.Select("rae_referrer_additional_email_id=" + lblId.Text);
            DataRow thisRow = foundRows[0];



            Utilities.AddConfirmationBox(e);
            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
                Utilities.SetEditRowBackColour(e, System.Drawing.Color.LightGoldenrodYellow);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
        }
    }
    protected void GrdReferrerAdditionalEmails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GrdReferrerAdditionalEmails.EditIndex = -1;
        FillGrdReferrerAdditionalEmails();
    }
    protected void GrdReferrerAdditionalEmails_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        Label   lblId    = (Label)GrdReferrerAdditionalEmails.Rows[e.RowIndex].FindControl("lblId");
        TextBox txtName  = (TextBox)GrdReferrerAdditionalEmails.Rows[e.RowIndex].FindControl("txtName");
        TextBox txtEmail = (TextBox)GrdReferrerAdditionalEmails.Rows[e.RowIndex].FindControl("txtEmail");


        txtName.Text = txtName.Text.Trim();
        txtEmail.Text = txtEmail.Text.Trim();

        if (txtName.Text.Length == 0)
        {
            SetErrorMessage("Referrer Additional Emails - Name is required");
            return;
        }
        if (txtEmail.Text.Length == 0)
        {
            SetErrorMessage("Referrer Additional Emails - Email is required");
            return;
        }
        if (!Utilities.IsValidEmailAddress(txtEmail.Text))
        {
            SetErrorMessage("Referrer Additional Emails - Invalid email address");
            return;
        }


        ReferrerAdditionalEmailDB.Update(Convert.ToInt32(lblId.Text), txtName.Text, txtEmail.Text);

        GrdReferrerAdditionalEmails.EditIndex = -1;
        FillGrdReferrerAdditionalEmails();
    }
    protected void GrdReferrerAdditionalEmails_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
    }
    protected void GrdReferrerAdditionalEmails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("Insert"))
        {
            TextBox txtName = (TextBox)GrdReferrerAdditionalEmails.FooterRow.FindControl("txtNewName");
            TextBox txtEmail = (TextBox)GrdReferrerAdditionalEmails.FooterRow.FindControl("txtNewEmail");


            txtName.Text  = txtName.Text.Trim();
            txtEmail.Text = txtEmail.Text.Trim();

            if (txtName.Text.Length == 0)
            {
                SetErrorMessage("Referrer Additional Emails - Name is required");
                return;
            }
            if (txtEmail.Text.Length == 0)
            {
                SetErrorMessage("Referrer Additional Emails - Email is required");
                return;
            }
            if (!Utilities.IsValidEmailAddress(txtEmail.Text))
            {
                SetErrorMessage("Referrer Additional Emails - Invalid email address");
                return;
            }


            Patient patient = PatientDB.GetByID(GetFormPTID());
            ReferrerAdditionalEmailDB.Insert(patient.PatientID, txtName.Text, txtEmail.Text);
            FillGrdReferrerAdditionalEmails();
        }

        if (e.CommandName.Equals("_Delete") || e.CommandName.Equals("_UnDelete"))
        {
            int referrer_additional_email_id = Convert.ToInt32(e.CommandArgument);

            try
            {
                if (e.CommandName.Equals("_Delete"))
                    ReferrerAdditionalEmailDB.UpdateDeleted(referrer_additional_email_id, Convert.ToInt32(ViewState["StaffID"]));
                else
                    ReferrerAdditionalEmailDB.UpdateNotDeleted(referrer_additional_email_id);
            }
            catch (ForeignKeyConstraintException fkcEx)
            {
                SetErrorMessage("Can not delete because other records depend on this" + (Utilities.IsDev() ? " : " + fkcEx.Message : "") );
            }

            FillGrdReferrerAdditionalEmails();
        }
    }
    protected void GrdReferrerAdditionalEmails_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GrdReferrerAdditionalEmails.EditIndex = e.NewEditIndex;
        FillGrdReferrerAdditionalEmails();
    }
    protected void GrdReferrerAdditionalEmails_Sorting(object sender, GridViewSortEventArgs e)
    {
        // dont allow sorting if in edit mode
        if (GrdReferrerAdditionalEmails.EditIndex >= 0)
            return;

        SortReferrerAdditionalEmails(e.SortExpression);
    }
    protected void SortReferrerAdditionalEmails(string sortExpression, params string[] sortExpr)
    {
        DataTable dataTable = ViewState["referreradditionalemail_data"] as DataTable;

        if (dataTable != null)
        {
            if (ViewState["referreradditionalemail_sortexpression"] == null)
                ViewState["referreradditionalemail_sortexpression"] = "";

            DataView dataView = new DataView(dataTable);
            string[] sortData = ViewState["referreradditionalemail_sortexpression"].ToString().Trim().Split(' ');

            string newSortExpr = (sortExpr.Length == 0) ?
                (sortExpression == sortData[0] && sortData[1] == "ASC") ? "DESC" : "ASC" :
                sortExpr[0];

            dataView.Sort = sortExpression + " " + newSortExpr;
            ViewState["referreradditionalemail_sortexpression"] = sortExpression + " " + newSortExpr;

            GrdReferrerAdditionalEmails.DataSource = dataView;
            GrdReferrerAdditionalEmails.DataBind();
        }
    }

    #endregion

    #region SetErrorMessage, HideErrorMessage

    private void HideTableAndSetErrorMessage(string errMsg = "", string details = "")
    {
        SetErrorMessage(errMsg, details);
    }
    private void SetErrorMessage(string errMsg = "", string details = "")
    {
        if (errMsg.Contains(Environment.NewLine))
            errMsg = errMsg.Replace(Environment.NewLine, "<br />");

        // double escape so shows up literally on webpage for 'alert' message
        string detailsToDisplay = (details.Length == 0 ? "" : " <a href=\"#\" onclick=\"alert('" + details.Replace("\\", "\\\\").Replace("\r", "\\r").Replace("\n", "\\n").Replace("'", "\\'").Replace("\"", "\\'") + "'); return false;\">Details</a>");

        lblErrorMessage.Visible = true;
        if (errMsg != null && errMsg.Length > 0)
            lblErrorMessage.Text = errMsg + detailsToDisplay + "<br />";
        else
            lblErrorMessage.Text = "An error has occurred. Plase contact the system administrator. " + detailsToDisplay + "<br />";
    }
    private void HideErrorMessage()
    {
        lblErrorMessage.Visible = false;
        lblErrorMessage.Text = "";
    }

    #endregion

}