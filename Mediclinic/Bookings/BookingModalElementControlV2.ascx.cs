﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Bookings_BookingModalElementControlV2 : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txtModalPopupBookFullDays_StartDate_Picker.OnClientClick = "displayDatePicker('txtModalPopupBookFullDays_StartDate', this, 'dmy', '-'); return false;";
        txtModalPopupBookFullDays_EndDate_Picker.OnClientClick = "displayDatePicker('txtModalPopupBookFullDays_EndDate', this, 'dmy', '-'); return false;";

        txtModalPopupUnavailableRecurring_StartDate_Picker.OnClientClick = "displayDatePicker('txtModalPopupUnavailableRecurring_StartDate', this, 'dmy', '-'); return false;";
        txtModalPopupUnavailableRecurring_EndDate_Picker.OnClientClick   = "displayDatePicker('txtModalPopupUnavailableRecurring_EndDate', this, 'dmy', '-'); return false;";

        txtModalPopupUnavailableRecurring_StartDate.Text = DateTime.Now.ToString("dd-MM-yyyy");
    }

    public void SetModalDropDownList(StartEndTime startEndTime)
    {
        int minBookingDurationMins = 10;
        if (Convert.ToBoolean(Session["SiteIsClinic"]))
            minBookingDurationMins = Convert.ToInt32(((SystemVariables)Session["SystemVariables"])["BookingSheetTimeSlotMins_Clinic"].Value );
        else if (Convert.ToBoolean(Session["SiteIsAgedCare"]))
            minBookingDurationMins = Convert.ToInt32( ((SystemVariables)Session["SystemVariables"])["BookingSheetTimeSlotMins_AgedCare"].Value );
        else if (Convert.ToBoolean(Session["SiteIsGP"]))
            minBookingDurationMins = Convert.ToInt32( ((SystemVariables)Session["SystemVariables"])["BookingSheetTimeSlotMins_GP"].Value );


        ddlModalStartHour.Items.Clear();
        ddlModalEndHour.Items.Clear();
        ddlModalStartMinute.Items.Clear();
        ddlModalEndMinute.Items.Clear();

        for (int i = startEndTime.StartTime.Hours; i <= startEndTime.EndTime.Hours; i++)
        {
            ddlModalStartHour.Items.Add(new ListItem(i.ToString().PadLeft(2, '0'), i.ToString().PadLeft(2, '0')));
            ddlModalEndHour.Items.Add(new ListItem(i.ToString().PadLeft(2, '0'), i.ToString().PadLeft(2, '0')));
        }
        for (int i = 0; i < 60; i += minBookingDurationMins)
        {
            ddlModalStartMinute.Items.Add(new ListItem(i.ToString().PadLeft(2, '0'), i.ToString().PadLeft(2, '0')));
            ddlModalEndMinute.Items.Add(new ListItem(i.ToString().PadLeft(2, '0'), i.ToString().PadLeft(2, '0')));
        }


        for (int i = 0; i <= 23; i++)
        {
            ddlModalPopupUnavailableRecurringModalStartHour.Items.Add(new ListItem(i.ToString().PadLeft(2, '0'), i.ToString().PadLeft(2, '0')));
            ddlModalPopupUnavailableRecurringModalEndHour.Items.Add(new ListItem(i.ToString().PadLeft(2, '0'), i.ToString().PadLeft(2, '0')));
        }
        for (int i = 0; i < 60; i += minBookingDurationMins)
        {
            ddlModalPopupUnavailableRecurringModalStartMinute.Items.Add(new ListItem(i.ToString().PadLeft(2, '0'), i.ToString().PadLeft(2, '0')));
            ddlModalPopupUnavailableRecurringModalEndMinute.Items.Add(new ListItem(i.ToString().PadLeft(2, '0'), i.ToString().PadLeft(2, '0')));
        }

        
        ddlOrgUnavailabilityReason.Items.Add(new ListItem("[None]", "-1"));
        DataTable tblUnavailabilityReasons = DBBase.GetGenericDataTable_WithWhereOrderClause(null, "BookingUnavailabilityReason", "", "descr", "booking_unavailability_reason_id", "booking_unavailability_reason_type_id", "descr");
        foreach(DataRow row in tblUnavailabilityReasons.Rows)
        {
            if (row["booking_unavailability_reason_type_id"].ToString() == "341")
                ddlProvUnavailabilityReason.Items.Add(new ListItem(row["descr"].ToString(), row["booking_unavailability_reason_id"].ToString()));
            else if (row["booking_unavailability_reason_type_id"].ToString() == "340")
                ddlOrgUnavailabilityReason.Items.Add(new ListItem(row["descr"].ToString(), row["booking_unavailability_reason_id"].ToString()));
        }


        //DataTable tblBookingChangeHistoryReasons = DBBase.GetGenericDataTable_WithWhereOrderClause("BookingChangeHistoryReason", "", "display_order, descr", "booking_change_history_reason_id", "descr", "display_order");
        DataTable tblBookingChangeHistoryReasons = BookingChangeHistoryReasonDB.GetDataTable();
        foreach (DataRow row in tblBookingChangeHistoryReasons.Rows)
            ddlBookingMovementReason.Items.Add(new ListItem(row["descr"].ToString(), row["booking_change_history_reason_id"].ToString()));

        ddlEveryNWeeks.Items.Clear();
        for (int i = 1; i <= 13; i++)
            ddlEveryNWeeks.Items.Add(new ListItem(i.ToString(), i.ToString()));

        ddlOcurrences.Items.Clear();
        for (int i = 1; i <= 13; i++)
            ddlOcurrences.Items.Add(new ListItem(i.ToString(), i.ToString()));

        ddlUnavailableEveryNWeeks.Items.Clear();
        for (int i = 1; i <= 13; i++)
            ddlUnavailableEveryNWeeks.Items.Add(new ListItem(i.ToString(), i.ToString()));
    }

    public void ShowAddBtn(bool show)
    {
        btnModalSubmitAdd.Visible = show;
        btnModalPopupBookFullDays_SubmitAdd.Visible = show;
        btnModalPopupUnavailableRecurring_SubmitAdd.Visible = show;
    }
    public void ShowUpdateBtn(bool show)
    {
        btnModalSubmitUpdate.Visible = show;
        btnModalPopupBookFullDays_SubmitUpdate.Visible = show;
        btnModalPopupUnavailableRecurring_SubmitUpdate.Visible = show;
    }


    public void SetMinutesEditable(bool entabled)
    {
        ddlModalStartMinute.Enabled = entabled;
        ddlModalEndMinute.Enabled = entabled;
    }


}