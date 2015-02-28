using System;
using System.IO;
using System.Web;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data;
using DataSetVepAdminTableAdapters;

public partial class Servizi : System.Web.UI.Page
{

  static string ReadTemplateFromFile(string templateType)
  {
    string fileName = HttpContext.Current.Server.MapPath("~\\public\\templates\\" + templateType);
    var output = "";
    if (!File.Exists(fileName))
      return output;
    var stFile = File.OpenText(fileName);
    output = stFile.ReadToEnd();
    stFile.Close();
    return output;
  }


  protected void Page_Load(object sender, EventArgs e)
  {
    if (!IsPostBack)
    {
      var strTemplateAzienda = ReadTemplateFromFile("template_servizi.html");
      //elimino i link ai css
      literalTemplate.Text = strTemplateAzienda.Remove(0, strTemplateAzienda.LastIndexOf("<!--CSS-->"));
      var table = new DataSetVepAdmin.NewsDataTable();
      var taNews = new NewsTableAdapter();
      DataTable dtNews = taNews.GetListaNews_OrderASC("21");
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
  }

  protected void rptArchivioOnItemDataBound(object sender, RepeaterItemEventArgs e)
  {
    var item = e.Item;
    var itemRow = (DataRowView)item.DataItem;
    var htmlAnchorItem = new HtmlGenericControl();

    if (System.Globalization.DateTimeFormatInfo.CurrentInfo != null)
      htmlAnchorItem.InnerHtml = string.Format("<li><a href=\"Blog.aspx?Mese={0}&Anno={1}\">{2}&nbsp;{1}&nbsp;" + "({3}) </a></li>", itemRow["Mese"], itemRow["Anno"], System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(int.Parse(itemRow["Mese"].ToString())), itemRow["Numero"]);
    item.Controls.Add(htmlAnchorItem);
  }
}
