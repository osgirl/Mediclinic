using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;


public class ReferrerAdditionalEmailDB
{

    public static void Delete(int referrer_additional_email_id)
    {
        try
        {
            DBBase.ExecuteNonResult("DELETE FROM ReferrerAdditionalEmail WHERE referrer_additional_email_id = " + referrer_additional_email_id.ToString());
        }
        catch (System.Data.SqlClient.SqlException sqlEx)
        {
            if (sqlEx.Errors.Count > 0 && sqlEx.Errors[0].Number == 547) // Assume the interesting stuff is in the first error
                throw new ForeignKeyConstraintException(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType.Name, sqlEx);
            else
                throw;
        }
    }
    public static int Insert(int patient_id, string name, string email)
    {
        name  = name.Replace("'", "''");
        email = email.Replace("'", "''");
        string sql = "INSERT INTO ReferrerAdditionalEmail (patient_id,name,email,deleted_by,date_deleted) VALUES (" + patient_id + ",'" + name + "'," + "'" + email + "',NULL,NULL" + ");SELECT SCOPE_IDENTITY();";
        return Convert.ToInt32(DBBase.ExecuteSingleResult(sql));
    }

    public static void Update(int referrer_additional_email_id, string name, string email)
    {
        name  = name.Replace("'", "''");
        email = email.Replace("'", "''");
        string sql = "UPDATE ReferrerAdditionalEmail SET name = '" + name + "',email = '" + email + "' WHERE referrer_additional_email_id = " + referrer_additional_email_id.ToString();
        DBBase.ExecuteNonResult(sql);
    }
    public static void UpdateDeleted(int referrer_additional_email_id, int deleted_by)
    {
        string sql = "UPDATE ReferrerAdditionalEmail SET deleted_by = " + deleted_by + ",date_deleted = '" + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + "' WHERE referrer_additional_email_id = " + referrer_additional_email_id.ToString();
        DBBase.ExecuteNonResult(sql);
    }
    public static void UpdateNotDeleted(int referrer_additional_email_id)
    {
        string sql = "UPDATE ReferrerAdditionalEmail SET deleted_by = NULL, date_deleted = NULL WHERE referrer_additional_email_id = " + referrer_additional_email_id.ToString();
        DBBase.ExecuteNonResult(sql);
    }

    public static DataTable GetDataTable()
    {
        string sql = JoinedSql;
        return DBBase.ExecuteQuery(sql).Tables[0];
    }
    public static ReferrerAdditionalEmail GetByID(int referrer_additional_email_id)
    {
        string sql = JoinedSql + " WHERE rae.referrer_additional_email_id = " + referrer_additional_email_id.ToString();
        DataTable tbl = DBBase.ExecuteQuery(sql).Tables[0];
        return (tbl.Rows.Count == 0) ? null : Load(tbl.Rows[0]);
    }
    public static DataTable GetDataTable_ByPatient(int patient_id, bool inc_deleted)
    {
        string sql = JoinedSql + " WHERE rae.patient_id = " + patient_id.ToString() + (inc_deleted ? "" : " AND rae.deleted_by IS NULL AND rae.date_deleted IS NULL");
        return DBBase.ExecuteQuery(sql).Tables[0];
    }


    public static string JoinedSql = @"
                       SELECT   
                                rae.referrer_additional_email_id as rae_referrer_additional_email_id,
                                rae.patient_id                   as rae_patient_id,
                                rae.name                         as rae_name,
                                rae.email                        as rae_email,
                                rae.deleted_by                   as rae_deleted_by,
                                rae.date_deleted                 as rae_date_deleted,

                                deleted_by.staff_id as deleted_by_staff_id, deleted_by.person_id as deleted_by_person_id, deleted_by.login as deleted_by_login, deleted_by.pwd as deleted_by_pwd, 
                                deleted_by.staff_position_id as deleted_by_staff_position_id, deleted_by.field_id as deleted_by_field_id, deleted_by.costcentre_id as deleted_by_costcentre_id, 
                                deleted_by.is_contractor as deleted_by_is_contractor, deleted_by.tfn as deleted_by_tfn, deleted_by.provider_number as deleted_by_provider_number, 
                                deleted_by.is_fired as deleted_by_is_fired, deleted_by.is_commission as deleted_by_is_commission, deleted_by.commission_percent as deleted_by_commission_percent, 
                                deleted_by.is_stakeholder as deleted_by_is_stakeholder, deleted_by.is_master_admin as deleted_by_is_master_admin, deleted_by.is_admin as deleted_by_is_admin, deleted_by.is_principal as deleted_by_is_principal, deleted_by.is_provider as deleted_by_is_provider, deleted_by.is_external as deleted_by_is_external,
                                deleted_by.staff_date_added as deleted_by_staff_date_added, deleted_by.start_date as deleted_by_start_date, deleted_by.end_date as deleted_by_end_date, deleted_by.comment as deleted_by_comment, 
                                deleted_by.num_days_to_display_on_booking_screen as deleted_by_num_days_to_display_on_booking_screen,  deleted_by.show_header_on_booking_screen as deleted_by_show_header_on_booking_screen,
                                deleted_by.bk_screen_field_id as deleted_by_bk_screen_field_id, deleted_by.bk_screen_show_key as deleted_by_bk_screen_show_key, deleted_by.enable_daily_reminder_sms as deleted_by_enable_daily_reminder_sms, deleted_by.enable_daily_reminder_email as deleted_by_enable_daily_reminder_email, deleted_by.hide_booking_notes as deleted_by_hide_booking_notes
                                ,
                                " + PersonDB.GetFields("person_deleted_by_", "person_deleted_by") + @"
                                ,
                                title_deleted_by.title_id as title_deleted_by_title_id, title_deleted_by.descr as title_deleted_by_descr

                       FROM     
                                ReferrerAdditionalEmail rae
                                LEFT OUTER JOIN Staff  deleted_by               ON deleted_by.staff_id           = rae.deleted_by
                                LEFT OUTER JOIN Person person_deleted_by        ON person_deleted_by.person_id   = deleted_by.person_id
                                LEFT OUTER JOIN Title  title_deleted_by         ON title_deleted_by.title_id     = person_deleted_by.title_id";

    public static ReferrerAdditionalEmail LoadAll(DataRow row)
    {
        ReferrerAdditionalEmail rae = Load(row);

        rae.DeletedBy = StaffDB.Load(row, "deleted_by_");
        rae.DeletedBy.Person = PersonDB.Load(row, "person_deleted_by_");
        rae.DeletedBy.Person.Title = IDandDescrDB.Load(row, "title_deleted_by_title_id", "title_deleted_by_descr");

        return rae;
    }

    public static ReferrerAdditionalEmail Load(DataRow row, string prefix = "")
    {
        return new ReferrerAdditionalEmail(
            Convert.ToInt32(row[prefix  + "referrer_additional_email_id"]),
            Convert.ToInt32(row[prefix + "patient_id"]),
            Convert.ToString(row[prefix + "name"]),
            Convert.ToString(row[prefix + "email"]),
            row[prefix + "deleted_by"]   == DBNull.Value ? -1                : Convert.ToInt32(row[prefix + "deleted_by"]),
            row[prefix + "date_deleted"] == DBNull.Value ? DateTime.MinValue : Convert.ToDateTime(row[prefix + "date_deleted"])
        );
    }

}