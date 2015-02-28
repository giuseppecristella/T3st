using System;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DivError.Visible = false;
        ContattilblNotificationErr.Visible = false;
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        //
        // Validate user, check login, create authentication ticket, populate roles, etc.
        // ...
        //

        if (Roles.IsUserInRole(Login1.UserName, "User"))
        {
            var profile = Profile.GetProfile(Login1.UserName);

            var loginCount = profile.LoginsCount;
            loginCount++;
            profile.LoginsCount = loginCount;

            profile.Save();

            Response.Redirect("~/Users/Default.aspx");
        }
        else if (Roles.IsUserInRole(Login1.UserName, "Administrator"))
        {            
            Response.Redirect("~/Admin/Default.aspx");
        }
    }

    protected void LoginError(object sender, EventArgs e)
    {
        DivError.Visible = true;
        ContattilblNotificationErr.Visible = true;

       // DivInfo.Visible = false;
    }
}
