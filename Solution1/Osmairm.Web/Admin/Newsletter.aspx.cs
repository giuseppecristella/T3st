using System;
using System.Data;
using System.Web;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.IO;


public enum MessageType
{
    Success,
    Error
}

public partial class Admin_ManageLinks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack) return;
        //carico il template
        fckEdtTemplateNewsLetter.Text = ReadTemplateFromFile("template_nl.html");
    }

    #region Event Handler

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        var taNewsletter = new DataSetVepAdminTableAdapters.NewsLetterTableAdapter();
        if (!Utility.ValidateMailAddress(txtEmail.Text))
        {
            ShowMessage(MessageType.Error, "Formato e-mail non valido. [Formato valido es. mail@host.it].");
            return;
        }
        taNewsletter.Insert(txtEmail.Text);
        txtEmail.Text = string.Empty;
        ShowMessage(MessageType.Success, "Utente aggiunto in archivio.");
        lvUsersSubscribed.DataBind();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        var taNewsletter = new DataSetVepAdminTableAdapters.NewsLetterTableAdapter();
        taNewsletter.Update(txtEmail.Text, int.Parse(hdnmailID.Value));
        txtEmail.Text = string.Empty;

        ShowMessage(MessageType.Success, "Aggiornamento effettuato con successo.");
        lvUsersSubscribed.DataBind();

        btnUpdate.Visible = false;
        btnInsert.Visible = true;
    }

    protected void lnkbtnSendNewsletter_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(fckEdtTemplateNewsLetter.Text))
        {
            ShowMessage(MessageType.Error, "Nessun template caricato per la newsletter.");
            return;
        }
        try
        {
            DataSetVepAdmin.NewsLetterDataTable dtNewsLetter;

            var dtSubscribedUsers = GetSubscibedUsers();
            if (dtSubscribedUsers.Rows.Count == 0)
            {
                ShowMessage(MessageType.Error, "Nessun utente in archivio.");
                return;
            }
            var from = new MailAddress("comunicazione@osmairm.it", "Comunicazione Osmairm");
           // var to = new MailAddress("giuseppe.cristella@libero.it", "test invio");

            SendNewsletterToSubscribedUsers(@from, dtSubscribedUsers);
        }
        catch (Exception Ex)
        {
            ShowMessage(MessageType.Error, Ex.Message);
        }
    }

    protected void lnkbtnSaveTemplate_OnClick(object sender, EventArgs e)
    {
        SaveTemplateToFile("template_nl.html", fckEdtTemplateNewsLetter.Text);
    }

    protected void lvUsersSubscribed_OnCreated(object sender, ListViewItemEventArgs e)
    {
    }

    protected void lvUsersSubscribed_OnItemCommand(object sender, ListViewCommandEventArgs e)
    {
        var dataItem = e.Item as ListViewDataItem;
        if (dataItem == null) return;

        var dataKey = lvUsersSubscribed.DataKeys[dataItem.DisplayIndex];
        if (dataKey == null) return;

        var mailId = dataKey.Value.ToString();
        var taNewsletter = new DataSetVepAdminTableAdapters.NewsLetterTableAdapter();
        DivSuccess.Visible = false;
        DivError.Visible = false;
        switch (e.CommandName)
        {
            case "cancella":
                {
                    taNewsletter.DeletebyId(int.Parse(mailId));
                    lvUsersSubscribed.DataBind();
                }
                break;
            case "modifica":
                {
                    DataTable dtNewsLetter = taNewsletter.GetDataById(int.Parse(mailId));
                    txtEmail.Text = dtNewsLetter.Rows[0]["email"].ToString();
                    btnUpdate.Visible = true;
                    btnInsert.Visible = false;
                    hdnmailID.Value = mailId;
                }
                break;
        }
    }

    #endregion

    #region Private Methods

    private string ReadTemplateFromFile(string fileName)
    {
        var path = HttpContext.Current.Server.MapPath("~\\public\\templates\\" + fileName);
        if (!File.Exists(path)) return string.Empty;

        using (var stFile = File.OpenText(path))
        {
            return stFile.ReadToEnd();
            // stFile.Close();
        }
    }

    private bool SaveTemplateToFile(string fileName, string template)
    {
        var path = HttpContext.Current.Server.MapPath("~\\public\\templates\\" + fileName);
        if (!File.Exists(path)) return false;
        try
        {
            File.WriteAllText(path, template);
        }
        catch (Exception)
        {
            return false;
        }
        return true;
    }

    private void ShowMessage(MessageType type, string message)
    {
        if (type == MessageType.Error)
        {
            LabelError.Text = message;
        }
        else
        {
            LabelSuccess.Text = message;
        }
        DivError.Visible = (type == MessageType.Error);
        DivSuccess.Visible = (type == MessageType.Success);
    }

    private DataTable GetSubscibedUsers()
    {
        var taNewsLett = new DataSetVepAdminTableAdapters.NewsLetterTableAdapter();
        return taNewsLett.GetListaMailNewsLetter();
    }

    private void SendNewsletterToSubscribedUsers(MailAddress @from, DataTable dtSubscribedUsers)
    {
        var sent = 0;
        for (var numDestinatari = 0; numDestinatari < dtSubscribedUsers.Rows.Count; numDestinatari++)
        {
            using (var email = new MailMessage(@from, new MailAddress(dtSubscribedUsers.Rows[numDestinatari][0].ToString())))
            {
                email.Subject = "Newsletter Osmairm";
                email.IsBodyHtml = true;
                email.Body = fckEdtTemplateNewsLetter.Text;

                //   email.Bcc.Add(dtSubscribedUsers.Rows[numDestinatari][0].ToString());
                var smtpMail = new SmtpClient();
                smtpMail.Send(email);
                sent++;
            }
        }
        ShowMessage(MessageType.Success, string.Format("Newsletter sended to {0} users.", sent));
    }

    #endregion

    protected void gotosliderPage(object sender, EventArgs e)
    {
    }


}
