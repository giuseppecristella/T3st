using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.Services;
using DataSetVepAdminTableAdapters;
 

public partial class AngularTestWithMaster : System.Web.UI.Page
{
  protected void Page_Load(object sender, EventArgs e)
  {

  }

  [WebMethod]
  public static List<Post> GetPostContents(int startingPageIndex, int pageSize)
  {
    
    var taNews = new NewsTableAdapter();
    DataTable dtNews = taNews.GetListaNews("0");

    
    // join linq??
    var posts =  (from DataRow news in dtNews.Rows
            select new Post
            {
              Titolo = news["Titolo"].ToString(),
              Descrizione = news["Descrizione"].ToString(),
              Data = (DateTime)news["Data"],
              Video = Regex.Match(news["Video"].ToString(), "<iframe.+?src=[\"'](.+?)[\"'].*?>", RegexOptions.IgnoreCase).Groups[1].Value.Replace("//", "http://"),
              Img = (news["UrlFotoHome"].ToString() == "img/Foto/standardNews.jpg") ? string.Empty : news["UrlFotoHome"].ToString(),
              Gallery = new List<string>(),
              IsQuote = (bool)news["Ws_Flag"]
            }).ToList().OrderByDescending(n => n.Data).Take(pageSize).ToList();
    return posts;
  }

  public class Post
  {
    public string Titolo;
    public string Descrizione;
    public DateTime Data;
    public string Video;
    public string Img;
    public bool IsQuote;
    public List<string> Gallery;
  }

}