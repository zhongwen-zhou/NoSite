KindEditor.plugin("wordpaste",function(e){var t=this,i="wordpaste";t.clickToolbar(i,function(){var o=t.lang(i+"."),a='<div style="padding:10px 20px;"><div style="margin-bottom:10px;">'+o.comment+"</div>"+'<iframe class="ke-textarea" frameborder="0" style="width:408px;height:260px;"></iframe>'+"</div>",n=t.createDialog({name:i,width:450,title:t.lang(i),body:a,yesBtn:{name:t.lang("yes"),click:function(){var i=l.body.innerHTML;i=e.clearMsWord(i,t.filterMode?t.htmlTags:e.options.htmlTags),t.insertHtml(i).hideDialog().focus()}}}),r=n.div,d=e("iframe",r),l=e.iframeDoc(d);e.IE||(l.designMode="on"),l.open(),l.write("<!doctype html><html><head><title>WordPaste</title></head>"),l.write('<body style="background-color:#FFF;font-size:12px;margin:2px;">'),e.IE||l.write("<br />"),l.write("</body></html>"),l.close(),e.IE&&(l.body.contentEditable="true"),d[0].contentWindow.focus()})});