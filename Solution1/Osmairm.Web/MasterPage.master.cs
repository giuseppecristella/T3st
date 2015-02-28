using System;
using System.IO;
using System.Web.UI.HtmlControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
  protected void Page_Load(object sender, EventArgs e)
  {
    CreateJavascriptAndStyleTag();
  }


  private void SetCurrentHrefStyle()
  {
    var pageName = Path.GetFileName(Request.Path).Replace(".aspx", string.Empty);
    var controlName = "h" + pageName;

    switch (pageName)
    {
      case "ProgettoDett":
        controlName = "hProgetti";
        break;
      case "NewsDetail":
        controlName = "hBlog";
        break;
    }
    var hrefToSet = FindControl(controlName) as HtmlAnchor;
    if (hrefToSet == null) return;
    hrefToSet.Attributes["class"] = "current";
  }

  private void CreateJavascriptAndStyleTag()
  {
    ltrCssStyleSheets.Text = string.Format("<link href=\"{0}/css/style.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"  />" +
                                           "<link href=\"{0}/css/Yellow.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"   />" +
                                           "<link href=\"{0}/css/blog.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"   />" +
                                           "<link href=\"{0}/css/socialize-bookmarks.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"  />" +
                                           "<link href=\"{0}/css/portfolio-item.css\" rel=\"stylesheet\" type=\"text/css\" media=\"screen\"  />" +
                                           "<link href=\"{0}/css/prettyPhoto.css\" rel=\"stylesheet\" type=\"text/css\"/>"
                                           , Utility.GetAbsoluteUrl());

    ltrJavascripts.Text = "";
    ltrJavascripts.Text = string.Format("<script type=\"text/javascript\" src=\"{0}/javascript/jquery.js\">" +
                                        "</script><script type=\"text/javascript\" src=\"{0}/javascript/custom.js\">" +
                                        "</script><script type=\"text/javascript\" src=\"{0}/javascript/bra.photostream.js\">" +
                                        "</script><script type=\"text/javascript\" src=\"{0}/javascript/prettyPhoto.js\"></script>"
                                        , Utility.GetAbsoluteUrl());
  }



  #region Garbage FB Meta
  /*
    string qString = "";
    if (Page.Request.QueryString.Count>0) qString = 
    "?"+Page.Request.QueryString.ToString();
      btnLangEN.PostBackUrl = absolutePath + Page.Request.AppRelativeCurrentExecutionFilePath.Replace("~", "en") + qString;
    btnLangDE.PostBackUrl = absolutePath + Page.Request.AppRelativeCurrentExecutionFilePath.Replace("~", "de") +
                            qString;
    btnLangIT.PostBackUrl = absolutePath + Page.Request.AppRelativeCurrentExecutionFilePath.Replace("~", "it") + qString;
          ltrMetaFB.Text = (string)Session["metatagFB"];
    if (!IsPostBack)
    {
        string _social_fb = Utility.SearchConfigValue("social_fb");
        social_fb.HRef = _social_fb;
        string _social_google = Utility.SearchConfigValue("social_google");
        social_google.HRef = _social_google;
        string _social_tw = Utility.SearchConfigValue("social_tw");
        social_tw.HRef = _social_tw;
        string _social_yt = Utility.SearchConfigValue("social_yt");
        social_yt.HRef = _social_yt;
    }
    */
  // Page.Request.Path
  //  Page.Request.
  //HtmlGenericControl liMenu = (HtmlGenericControl)FindControl("menu");
  //if (liMenu.InnerHtml.Contains(Path.GetFileName(Page.Request.Path)))
  //{
  //    liMenu.InnerHtml = 
  //    liMenu.InnerHtml.Replace("href=\"" + Path.GetFileName(Page.Request.Path) + "\"", "href=\"" + Path.GetFileName(Page.Request.Path) + "\""+" class=\"current\"");
  //} 
  #endregion
}
