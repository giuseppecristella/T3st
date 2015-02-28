using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
public partial class Admin : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string utente = Page.User.Identity.Name;
        //string ruolo = (Roles.GetRolesForUser(utente)[0]);
        //UserRole.Text = string.Format("Authenticated as {0}", ruolo);
        if (!IsPostBack) //check if the webpage is loaded for the first time.
        {
        }
        else
        {
        }
    }
}
