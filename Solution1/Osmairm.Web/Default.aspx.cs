using System;

using System.Web.Services;


public partial class _Default : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }

  [WebMethod]
  public static SubscribeUserResult SubscribeUser(UserToSubscibe user)
  {
    var taNewsletter = new DataSetVepAdminTableAdapters.NewsLetterTableAdapter();
    var foundedEmail = taNewsletter.GetEmail(user.Email);
    if (foundedEmail.Count > 0) return new SubscribeUserResult
    {
      Result = false,
      Message = "Attenzione: Indirizzo e-mail già presete nei nostri archivi, pertanto non è possibile procedere con la registrazione."
    };
    taNewsletter.Insert(user.Email);
    return new SubscribeUserResult
    {
      Result = true,
      Message = "L'iscrizione alla newsletter è avvenuta con successo."
    };
  }

  public class UserToSubscibe
  {
    public string User;
    public string Email;
  }

  public class SubscribeUserResult
  {
    public bool Result;
    public string Message;
  }

}
