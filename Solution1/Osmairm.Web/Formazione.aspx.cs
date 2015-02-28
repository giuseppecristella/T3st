using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using DataSetVepAdminTableAdapters;
using System.Data;
public partial class Formazione : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {
    string strTemplateAzienda;
    if (IsPostBack) return;
    strTemplateAzienda = ReadTemplateFromFile("template_formazione.html");
    //elimino i link ai css
    literalTemplate.Text = strTemplateAzienda.Remove(0, strTemplateAzienda.LastIndexOf("<!--CSS-->"));
    var table = new DataSetVepAdmin.NewsDataTable();
    var taNews = new NewsTableAdapter();
    taNews.GetListaNews_OrderASC("21");
    try
    {
      taNews.FillBy8(table);
    }
    catch (ConstraintException ex)
    {

    }
    rptArchivio.DataSource = table;
    rptArchivio.DataBind();
  }

  private static string ReadTemplateFromFile(string templateType)
  {
    var fileName = HttpContext.Current.Server.MapPath("~\\public\\templates\\" + templateType);
 
    if (!File.Exists(fileName)) return string.Empty;
    using (var stFile = File.OpenText(fileName))
    {
      return stFile.ReadToEnd();
    }
  }

  protected void rptArchivio_OnItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    var item = e.Item;
    var itemRow = (DataRowView)item.DataItem;
    var htmlAnchorItem = new HtmlGenericControl();
    htmlAnchorItem.InnerHtml = string.Format("<li><a href=\"Blog.aspx?Mese={0}&Anno={1}\">{2}&nbsp;{1}&nbsp;" + "({3}) </a></li>", 
      itemRow["Mese"], itemRow["Anno"], 
      System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(itemRow["Mese"].ToString())), 
      itemRow["Numero"]);
    item.Controls.Add(htmlAnchorItem);
  }


}
