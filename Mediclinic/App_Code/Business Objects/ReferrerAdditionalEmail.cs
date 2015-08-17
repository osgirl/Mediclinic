using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


public class ReferrerAdditionalEmail
{

    public ReferrerAdditionalEmail(int referrer_additional_email_id, int patient_id, string name, string email, int deleted_by, DateTime date_deleted)
    {
        this.referrer_additional_email_id = referrer_additional_email_id;
        this.patient_id                   = patient_id;
        this.name                         = name;
        this.email                        = email;
        this.deleted_by                   = deleted_by == -1 ? null : new Staff(deleted_by);
        this.date_deleted                 = date_deleted;
    }

    private int referrer_additional_email_id;
    public int ReferrerAdditionalEmailID
    {
        get { return this.referrer_additional_email_id; }
        set { this.referrer_additional_email_id = value; }
    }
    private int patient_id;
    public int PatientID
    {
        get { return this.patient_id; }
        set { this.patient_id = value; }
    }
    private string name;
    public string Name
    {
        get { return this.name; }
        set { this.name = value; }
    }
    private string email;
    public string Email
    {
        get { return this.email; }
        set { this.email = value; }
    }
    private Staff deleted_by;
    public Staff DeletedBy
    {
        get { return this.deleted_by; }
        set { this.deleted_by = value; }
    }
    private DateTime date_deleted;
    public DateTime DateDeleted
    {
        get { return this.date_deleted; }
        set { this.date_deleted = value; }
    }
    public override string ToString()
    {
        return referrer_additional_email_id.ToString() + " " + name.ToString() + " " + email.ToString() + " " + deleted_by.ToString() + " " + date_deleted.ToString();
    }

}