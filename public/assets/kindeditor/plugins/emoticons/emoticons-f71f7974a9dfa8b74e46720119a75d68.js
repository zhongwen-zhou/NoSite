KindEditor.plugin("emoticons",function(e){var i=this,n="emoticons",o=i.emoticonsPath||i.pluginsPath+"emoticons/images/",s=void 0===i.allowPreviewEmoticons?!0:i.allowPreviewEmoticons,a=1;i.clickToolbar(n,function(){function t(n,s,a){C?n.mouseover(function(){s>h?(C.css("left",0),C.css("right","")):(C.css("left",""),C.css("right",0)),P.attr("src",o+a+".gif"),e(this).addClass("ke-on")}):n.mouseover(function(){e(this).addClass("ke-on")}),n.mouseout(function(){e(this).removeClass("ke-on")}),n.click(function(e){i.insertHtml('<img src="'+o+a+'.gif" border="0" alt="" />').hideMenu().focus(),e.stop()})}function c(i,n){var s=document.createElement("table");n.append(s),C&&(e(s).mouseover(function(){C.show("block")}),e(s).mouseout(function(){C.hide()}),b.push(e(s))),s.className="ke-table",s.cellPadding=0,s.cellSpacing=0,s.border=0;for(var a=(i-1)*m+f,c=0;u>c;c++)for(var r=s.insertRow(c),l=0;d>l;l++){var p=e(r.insertCell(l));p.addClass("ke-cell"),t(p,l,a);var v=e('<span class="ke-img"></span>').css("background-position","-"+24*a+"px 0px").css("background-image","url("+o+"static.gif)");p.append(v),b.push(p),a++}return s}function r(){e.each(b,function(){this.unbind()})}function l(e,i){e.click(function(e){r(),M.parentNode.removeChild(M),E.remove(),M=c(i,k),p(i),a=i,e.stop()})}function p(i){E=e('<div class="ke-page"></div>'),k.append(E);for(var n=1;g>=n;n++){if(i!==n){var o=e('<a href="javascript:;">['+n+"]</a>");l(o,n),E.append(o),b.push(o)}else E.append(e("@["+n+"]"));E.append(e("@&nbsp;"))}}var u=5,d=9,v=135,f=0,m=u*d,g=Math.ceil(v/m),h=Math.floor(d/2),k=e('<div class="ke-plugin-emoticons"></div>'),b=[],w=i.createMenu({name:n,beforeRemove:function(){r()}});w.div.append(k);var C,P;s&&(C=e('<div class="ke-preview"></div>').css("right",0),P=e('<img class="ke-preview-img" src="'+o+f+'.gif" />'),k.append(C),C.append(P));var E,M=c(a,k);p(a)})});