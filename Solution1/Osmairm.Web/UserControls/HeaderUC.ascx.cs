using System;
using System.Data;
using System.IO;
using System.Web.UI.HtmlControls;

public partial class HeaderUC : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
        DataTable dtNews = taNews.GetListaNews_OrderASC("21");
        CreateMenuStrutture(dtNews);
        SetCurrentHrefStyle();
    }

    private void CreateMenuStrutture(DataTable dtNews)
    {
        if (Request.Path.Contains("Strutture") || Request.Path.Contains("strutture"))
        {
            ltrl_ul_navigoss.Text = "<ul id=\"navigoss\">";
            for (var i = 0; i < dtNews.Rows.Count; i++)
            {
                ltr_li_struttura.Text +=
                  string.Format(
                    "<li class=\"nav-struttura-{0}\"  id=\"li_struttura_{0}\"><a   href=\"#struttura-{0}\">{1}</a></li>", (i + 1),
                    dtNews.Rows[i]["TestoENG"]);
            }
        }
        else
        {
            ltrl_ul_navigoss.Text = "<ul>";
            for (int i = 0; i < dtNews.Rows.Count; i++)
            {
                ltr_li_struttura.Text +=
                  string.Format(
                    "<li class=\"nav-struttura-{0}\"  id=\"li_struttura_{0}\"><a   href=\"strutture.aspx#struttura-{0}\">{1}</a></li>",
                    (i + 1), dtNews.Rows[i]["TestoENG"]);
            }
        }
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
}