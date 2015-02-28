using System;
using System.Drawing;
using System.Net.Mail;

public partial class Contatti : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    MailStatus.Text = "";
    if (!IsPostBack)
    {
      ContattiTxtNome.Value = (String)GetGlobalResourceObject("Res", "lblNomeMail");
      ContattiTxtEmail.Value = (String)GetGlobalResourceObject("Res", "lblemail");
      ContattiTxtOggetto.Value = (String)GetGlobalResourceObject("Res", "lblogg");
      ContattiTxtMessage.Value = (String)GetGlobalResourceObject("Res", "lblmsg");
    }

    if (ContattiTxtNome.Value == "Nome" || ContattiTxtNome.Value == "Name")
    {
      ContattiTxtNome.Value = (String)GetGlobalResourceObject("Res", "lblNomeMail");
    }
    if (ContattiTxtOggetto.Value == "Oggetto" || ContattiTxtOggetto.Value == "Subject" || ContattiTxtOggetto.Value == "Betreff")
    {
      ContattiTxtOggetto.Value = (String)GetGlobalResourceObject("Res", "lblogg");
    }
    if (ContattiTxtMessage.Value == "Messaggio" || ContattiTxtMessage.Value == "Message")
    {
      ContattiTxtMessage.Value = (String)GetGlobalResourceObject("Res", "lblmsg");
    }

    ContattiTxtNome.Attributes["onblur"] =
        "if(this.value == '') { this.value = '" + (String)GetGlobalResourceObject("Res", "lblNomeMail") + "'; }";
    ContattiTxtNome.Attributes["onfocus"] =
        "if(this.value == '" + (String)GetGlobalResourceObject("Res", "lblNomeMail") + "') { this.value = ''; }";

    ContattiTxtEmail.Attributes["onblur"] =
        "if(this.value == '') { this.value = '" + (String)GetGlobalResourceObject("Res", "lblemail") + "'; }";
    ContattiTxtEmail.Attributes["onfocus"] =
        "if(this.value == '" + (String)GetGlobalResourceObject("Res", "lblemail") + "') { this.value = ''; }";

    ContattiTxtOggetto.Attributes["onblur"] =
        "if(this.value == '') { this.value = '" + (String)GetGlobalResourceObject("Res", "lblogg") + "'; }";
    ContattiTxtOggetto.Attributes["onfocus"] =
        "if(this.value == '" + (String)GetGlobalResourceObject("Res", "lblogg") + "') { this.value = ''; }";

    ContattiTxtMessage.Attributes["onblur"] =
        "if(this.value == '') { this.value = '" + (String)GetGlobalResourceObject("Res", "lblmsg") + "'; }";
    ContattiTxtMessage.Attributes["onfocus"] =
        "if(this.value == '" + (String)GetGlobalResourceObject("Res", "lblmsg") + "') { this.value = ''; }";
  }

  protected void ButtonInvia_Click(object sender, EventArgs e)
  {
    var mainMailAddress = Utility.SearchConfigValue("MainMailAddress");
    var mainMailAlias = Utility.SearchConfigValue("MainMailAddress");
    var bccMailAddress = Utility.SearchConfigValue("BccMailAddress");
    if (ContattiTxtNome.Value != (String)GetGlobalResourceObject("Res", "lblNomeMail"))
    {
      if (ContattiTxtEmail.Value != (String)GetGlobalResourceObject("Res", "lblemail"))
      {
        if (Utility.ValidateMailAddress(ContattiTxtEmail.Value))
        {
          if (ContattiTxtOggetto.Value != (String)GetGlobalResourceObject("Res", "lblogg"))
          {
            if ((ContattiTxtMessage.Value != (String)GetGlobalResourceObject("Res", "lblmsg")) && (ContattiTxtMessage.Value != ""))
            {
              try
              {
                var from = new MailAddress(ContattiTxtEmail.Value, ContattiTxtNome.Value);
                var to = new MailAddress(mainMailAddress, mainMailAlias);
                var email = new MailMessage(from, to)
                {
                  Subject = ContattiTxtOggetto.Value,
                  IsBodyHtml = true,
                  Body = string.Format("<b>Messaggio inviato dal sito www.osmairm.it</b></br></br>" +
                                       "<b>Mittente:</b> {0}</br>" + "<b>email:</b> {1}</br></br>" + "<b>Messaggio:</b> " +
                                       "</br></br>{2}", ContattiTxtNome.Value, ContattiTxtEmail.Value,
                    ContattiTxtMessage.Value)
                };

                email.Bcc.Add(bccMailAddress);
                var smtpMail = new SmtpClient();
                smtpMail.Send(email);
                // invio OK!!
                MailStatus.Text = (String)GetGlobalResourceObject("Res", "lblMailSuccess");
                MailStatus.ForeColor = Color.Green;
                ContattiTxtNome.Value = "";
                ContattiTxtEmail.Value = "";
                ContattiTxtMessage.Value = "";
              }
              catch (Exception Ex)
              {
                MailStatus.Text = (String)GetGlobalResourceObject("Res", "lblGenericMailError");
                MailStatus.ForeColor = Color.Red;
              }
            }
            else
            {
              MailStatus.Text = (String)GetGlobalResourceObject("Res", "lblMessageMailError");
              MailStatus.ForeColor = Color.Red;
            }
          }
          else
          {
            MailStatus.Text = (String)GetGlobalResourceObject("Res", "lblSubjectMailError");
            MailStatus.ForeColor = Color.Red;
          }
        }
        else
        {
          MailStatus.Text = (String)GetGlobalResourceObject("Res", "lblWrongFormatMailError");
          MailStatus.ForeColor = Color.Red;
        }
      }
      else
      {
        MailStatus.Text = (String)GetGlobalResourceObject("Res", "lblEmailMailError");
        MailStatus.ForeColor = Color.Red;
      }
    }
    else
    {
      MailStatus.Text = (String)GetGlobalResourceObject("Res", "lblNomeMailError");
      MailStatus.ForeColor = Color.Red;
    }
  }
}
