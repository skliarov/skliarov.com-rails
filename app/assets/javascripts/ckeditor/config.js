CKEDITOR.stylesSet.add( 'styling', [
  { name: 'Code', element: 'code' },
  { name: 'Keyboard' , element: 'kbd' }
]);

CKEDITOR.editorConfig = function( config ) {
  
  // Insert from clipboard should be cleared from formating
  config.forcePasteAsPlainText = true;
  
  config.extraPlugins = 'highlight_js,youtube';
  
  config.format_tags = 'p;h1;h2;h3;h4;h5;h6';
  
  config.stylesSet = 'styling';
  
  config.toolbar = [
    ["Save", "-", "Source"],
    ["Highlight"],
    ["Undo", "Redo"],
    ["Bold",  "Italic",  "Underline",  "Strike",  "-",  "Subscript",  "Superscript", "-", "NumberedList", "BulletedList", "-", "Outdent", "Indent"],
    ["Link", "Unlink"],
    ["Image", "Youtube", "Table"],
    ["Maximize"],
    "/",
    ["Styles", "Format", "FontSize"],
    ["JustifyLeft", "JustifyCenter", "JustifyRight"],
    ["TextColor", "BGColor"]
  ];
  
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";
  
  // Rails CSRF token
  config.filebrowserParams = function(){
    var csrf_token, csrf_param, meta,
    metas = document.getElementsByTagName('meta'),
    params = new Object();
    
    for ( var i = 0 ; i < metas.length ; i++ ){
      meta = metas[i];
      
      switch(meta.name) {
      case "csrf-token":
        csrf_token = meta.content;
        break;
      case "csrf-param":
        csrf_param = meta.content;
        break;
      default:
        continue;
      }
    }
    
    if (csrf_param !== undefined && csrf_token !== undefined) {
      params[csrf_param] = csrf_token;
    }
    
    return params;
  };
  
  config.addQueryString = function( url, params ){
    var queryString = [];
    
    if ( !params ) {
      return url;
    } else {
      for ( var i in params )
        queryString.push( i + "=" + encodeURIComponent( params[ i ] ) );
    }
    
    return url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" );
  };
  
  // Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash)
  CKEDITOR.on( 'dialogDefinition', function( ev ){
    // Take the dialog name and its definition from the event data.
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;
    var content, upload;
    
    if (CKEDITOR.tools.indexOf(['link', 'image', 'attachment', 'flash'], dialogName) > -1) {
      content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'));
      upload = (content == null ? null : content.get('upload'));
      
      if (upload && upload.filebrowser && upload.filebrowser['params'] === undefined) {
        upload.filebrowser['params'] = config.filebrowserParams();
        upload.action = config.addQueryString(upload.action, upload.filebrowser['params']);
      }
    }
  });
};