$.fn.extend({ contentEditable : function(){ return this.on("mousedown", function () { $(this).attr("contenteditable", "true"); }).on("focusout", function () { $(this).removeAttr("contenteditable"); }); } });
$.fn.extend({ pFind : function(a, b){ return this.parents(a).find(b); } });
$.fn.extend({ pF : function(a, b){ return this.parents(a).find(b); } });
$.fn.extend({ pf : function(a, b){ return this.parents(a).find(b); } });
$.fn.extend({ toggleHtml : function(a, b){ return this.html(this.html() != a ? a : b); } });
$.fn.extend({ toggleStyle : function(a, b){ return this.attr("style", (this.attr("style") != a ? a : b) ); } });
$.fn.extend({ toggleText : function(a, b){ return this.text(this.text() != a ? a : b); } });
$.fn.extend({ toggleTextRotate90: function () { const a0 = `display: inline-block; transition-duration: 100ms;`; const a = a0 + `transform: rotate(90deg);`; const b = a0 + `transform: rotate(0deg);`; return this.toggleStyle(a, b); }});




