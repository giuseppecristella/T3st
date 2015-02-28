using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Magazine : System.Web.UI.Page
{

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
      if (!String.IsNullOrEmpty(Page.Request.QueryString["Tag"]))
      {
        DataTable dtNews = taNews.GetDataByTag(Page.Request.QueryString["Tag"], "1");
        ListViewMagazine.DataSource = dtNews;
      }
      else
      {
        DataTable dtNews = taNews.GetListaNews("5");
        ListViewMagazine.DataSource = dtNews;
      }
      ListViewMagazine.DataBind();
      ArrayList arrTags = new ArrayList();
      DataTable dtNewsList = taNews.GetListaNews("5");
      foreach (DataRow dr in dtNewsList.Rows)
      {
        string[] tagSplitted = dr["Tags"].ToString().Split(',');
        for (int i = 0; i < tagSplitted.Length; i++)
        {
          if (!arrTags.Contains(tagSplitted[i]))
          {
            arrTags.Add(tagSplitted[i]);
          }
        }

      }
      rptTags.DataSource = arrTags;
      rptTags.DataBind();
    }
  }

  /* rptTags*/
  protected void _itemDataBound(object sender, RepeaterItemEventArgs e)
  {
    RepeaterItem dataItem = (RepeaterItem)e.Item;
    HtmlGenericControl li_tag = new HtmlGenericControl();
    li_tag = (HtmlGenericControl)dataItem.FindControl("li_tag");
    li_tag.InnerHtml =
        "<a href=\"Progetti.aspx?tag=" + (string)dataItem.DataItem + "\" >" + (string)dataItem.DataItem + "</a>";
  }

}
