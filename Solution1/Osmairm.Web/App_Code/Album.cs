public class Album {

	private int _id;
	private int _count;
	private string _caption;
	private bool _ispublic;
    private int _tipoAlbum;

	public int AlbumID { get { return _id; } }
	public int Count { get { return _count; } }
	public string Caption { get { return _caption; } }
	public bool IsPublic { get { return _ispublic; } }
    public int TipoAlbum { get { return _tipoAlbum; } }

	public Album(int id, int count, string caption, bool ispublic, int tipo) {
		_id = id;
		_count = count;
		_caption = caption;
		_ispublic = ispublic;
        _tipoAlbum = tipo;
	}

}

