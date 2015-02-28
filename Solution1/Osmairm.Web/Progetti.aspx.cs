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

public partial class Progetti : System.Web.UI.Page
{

  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      DataSetVepAdminTableAdapters.NewsTableAdapter taNews = new DataSetVepAdminTableAdapters.NewsTableAdapter();
      if (!String.IsNullOrEmpty(Page.Request.QueryString["Tag"]))
      {
        DataTable dtNews = taNews.GetDataByTag(Page.Request.QueryString["Tag"], "1");
        ListViewProgetti.DataSource = dtNews;
      }
      else
      {
        DataTable dtNews = taNews.GetListaNews("1");
        ListViewProgetti.DataSource = dtNews;
      }
      ListViewProgetti.DataBind();
      ArrayList arrTags = new ArrayList();
      DataTable dtNewsList = taNews.GetListaNews("1");
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
    var tag = Request.QueryString["tag"];
    HtmlGenericControl li_tag = new HtmlGenericControl();
    li_tag = (HtmlGenericControl)dataItem.FindControl("li_tag");
    if ((string)dataItem.DataItem == tag)
      li_tag.InnerHtml =
          "<a class=\"tag-active\" href=\"Progetti.aspx?tag=" + (string)dataItem.DataItem + "\" >" + (string)dataItem.DataItem + "</a>";
    else
      li_tag.InnerHtml =
          "<a class=\"tag-celeste\" href=\"Progetti.aspx?tag=" + (string)dataItem.DataItem + "\" >" + (string)dataItem.DataItem + "</a>";
  }

}
