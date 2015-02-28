using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;

public partial class ManageFormazione : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    
        if (!IsPostBack)
        {
            FCKeditor1.Text = readTemplateFromFile("template_formazione.html");

        }
        

    }


    static string saveTemplateToFile(string templateType, string template_content)
    {
      //  string fileName = HttpContext.Current.Server.MapPath(Utility.SearchConfigValue("pathTemplateNl"));

         string fileName = HttpContext.Current.Server.MapPath("~\\public\\templates\\" + templateType);
        string output = "";

        if (!File.Exists(fileName))
            return output;
        File.WriteAllText(fileName, template_content);



        return output;

    }

    protected void ButtonSave_template(object sender, EventArgs e)
    {

        saveTemplateToFile("template_formazione.html", FCKeditor1.Text);
    }

    static string readTemplateFromFile(string templateType)
    {

        string fileName = HttpContext.Current.Server.MapPath("~\\public\\templates\\" + templateType);
      //  string fileName = HttpContext.Current.Server.MapPath(Utility.SearchConfigValue("pathTemplateNl"));


        string output = "";

        if (!File.Exists(fileName))
            return output;
        StreamReader stFile = File.OpenText(fileName);
        output = stFile.ReadToEnd();
        stFile.Close();


        return output;

    }

 

   
}
