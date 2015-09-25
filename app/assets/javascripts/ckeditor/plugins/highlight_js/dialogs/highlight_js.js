CKEDITOR.dialog.add( 'highlight_js', function( editor ) {
    return {
        title: editor.lang.highlight_js.highlight.dialogTitle,
        minWidth: 800,
        minHeight: 500,
        contents: [
            {
                id: 'tab-basic',
                label: 'Basic Settings',
                elements: [
                    {
                        type: 'select',
                        id: 'code_lan',
                        label: editor.lang.highlight_js.highlight.selectLabel,
                        items: [
                                [ 'No Highlight', 'no-highlight' ],
                                [ 'Auto', 'auto' ],
                                [ 'Swift', 'swift' ],
                                [ 'Objective C', 'objectivec' ],
                                [ 'Ruby', 'ruby' ],
                                [ 'HTML', 'xml' ],
                                [ 'CSS', 'css' ],
                                [ 'JavaScript', 'javascript' ],
                                [ 'CoffeeScript', 'coffeescript' ],
                                [ 'JSON', 'json' ],
                                [ 'XML', 'xml' ],
                                [ 'Markdown', 'markdown' ],
                                [ 'Bash', 'bash' ],
                                [ 'HTTP', 'http' ],
                                [ 'SQL', 'sql' ],
                                [ 'Nginx', 'ngix' ]
                              ],
                        'default': 'auto',
                        onChange: function(api) {
                            if(this.getValue() === 'popular' || this.getValue() === 'other'){
                                this.setValue(previous_value);
                            } else{
                                previous_value = this.getValue();
                            }
                        },
                        setup: function(element){
                            this.setValue(element.getAttribute( "class"));
                        },
                        commit: function(element){
                            var class_code = this.getValue();
                            if(class_code!=='auto'){
                                element.setAttribute("class", this.getValue());
                            }else{
                                element.removeAttribute( 'class' );
                            }
                        }
                    },
                    {
                        type: 'textarea',
                        id: 'pre_code',
                        rows: 20,
                        style: "width: 100%",
                        setup: function(element) {
                            this.setValue( element.getText() );
                        },
                        commit: function(element) {
                            element.setText( this.getValue() );
                        }
                    }
                ]
            }

        ],
        onShow: function(){
            var selection = editor.getSelection();
            var element = selection.getStartElement();

            if (element){
                element = element.getAscendant( 'code', true );
            }

            if (!element || element.getName() !== 'code'){
                previous_value = 'auto';
                element = editor.document.createElement('code');
                this.insertMode = true;
            }
            else{
                this.insertMode = false;
            }

            this.element = element;

            if (!this.insertMode){
                this.setupContent(this.element);
            }
        },
        onOk: function() {
            var dialog = this;
            var code = this.element;
			
            this.commitContent(code);
			
            if (this.insertMode){
                var pre = editor.document.createElement('pre');
                pre.append(code);
				
                editor.insertElement(pre);
            }
        }
    };
});