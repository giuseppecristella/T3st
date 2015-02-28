using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;

/// <summary>
/// Each node Corresponds to a record in tblTree
/// </summary>

public class VepTreeNode
{
    /* 
    MPTT: stands for Modified Preorder Tree Traversal 
    */
    public VepTreeNode(int id, int pId, string nome, string urlFoto, string descrizione)
    {
        _id = id;
        _parentID = pId;
        _nome = nome;
        _urlFoto = urlFoto;
        _descrizione = descrizione;
    }

    public string _nome
    {
        get { return _nome; }
        set { _nome = value; }
    }

    public string _urlFoto
    {
        get { return _urlFoto; }
        set { _urlFoto = value; }
    }

    public string _descrizione
    {
        get { return _descrizione; }
        set { _descrizione = value; }
    }

    protected int _id;
    public int ID
    {
        get { return _id; }
        set { _id = value; }
    }

    protected int _parentID;
    public int ParentID
    {
        get { return _parentID; }
        set { _parentID = value; }
    }

    public Object Tag;
}
