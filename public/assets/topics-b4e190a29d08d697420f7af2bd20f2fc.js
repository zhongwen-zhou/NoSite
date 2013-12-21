(function() {
  window.Topics = {
    replies_per_page: 50,
    appendImageFromUpload: function(srcs) {
      var before_text, caret_pos, source, src, src_merged, txtBox, _i, _len;

      txtBox = $(".topic_editor");
      caret_pos = txtBox.caret('pos');
      src_merged = "";
      for (_i = 0, _len = srcs.length; _i < _len; _i++) {
        src = srcs[_i];
        src_merged = "![](" + src + ")\n";
      }
      source = txtBox.val();
      before_text = source.slice(0, caret_pos);
      txtBox.val(before_text + src_merged + source.slice(caret_pos + 1, source.count));
      txtBox.caret('pos', caret_pos + src_merged.length);
      return txtBox.focus();
    },
    initUploader: function() {
      var opts;

      $("#topic_add_image").bind("click", function() {
        $(".topic_editor").focus();
        $("#topic_upload_images").click();
        return false;
      });
      opts = {
        url: "/photos",
        type: "POST",
        beforeSend: function() {
          $("#topic_add_image").hide();
          return $("#topic_add_image").before("<span class='loading'>上传中...</span>");
        },
        success: function(result, status, xhr) {
          $("#topic_add_image").parent().find("span.loading").remove();
          $("#topic_add_image").show();
          return Topics.appendImageFromUpload([result]);
        }
      };
      $("#topic_upload_images").fileUpload(opts);
      return false;
    },
    reply: function(floor, login) {
      var new_text, reply_body;

      reply_body = $("#reply_body");
      new_text = "#" + floor + "楼 @" + login + " ";
      if (reply_body.val().trim().length === 0) {
        new_text += '';
      } else {
        new_text = "\n" + new_text;
      }
      reply_body.focus().val(reply_body.val() + new_text);
      return false;
    },
    pageOfFloor: function(floor) {
      return Math.floor((floor - 1) / Topics.replies_per_page) + 1;
    },
    gotoFloor: function(floor) {
      var page, replyEl, url;

      replyEl = $("#reply" + floor);
      if (replyEl.length > 0) {
        Topics.highlightReply(replyEl);
      } else {
        page = Topics.pageOfFloor(floor);
        url = window.location.pathname + ("?page=" + page) + ("#reply" + floor);
        App.gotoUrl(url);
      }
      return replyEl;
    },
    highlightReply: function(replyEl) {
      $("#replies .reply").removeClass("light");
      return replyEl.addClass("light");
    },
    checkRepliesLikeStatus: function(user_liked_reply_ids) {
      var el, id, _i, _len, _results;

      _results = [];
      for (_i = 0, _len = user_liked_reply_ids.length; _i < _len; _i++) {
        id = user_liked_reply_ids[_i];
        el = $("#replies a.likeable[data-id=" + id + "]");
        _results.push(App.likeableAsLiked(el));
      }
      return _results;
    },
    replyCallback: function(success, msg) {
      $("#main .alert-message").remove();
      if (success) {
        $("abbr.timeago", $("#replies .reply").last()).timeago();
        $("abbr.timeago", $("#replies .total")).timeago();
        $("#new_reply textarea").val('');
        $("#preview").text('');
        App.notice(msg, '#reply');
      } else {
        App.alert(msg, '#reply');
      }
      $("#new_reply textarea").focus();
      return $('#btn_reply').button('reset');
    },
    preview: function(body) {
      $("#preview").text("Loading...");
      return $.post("/topics/preview", {
        "body": body
      }, function(data) {
        return $("#preview").html(data.body);
      }, "json");
    },
    hookPreview: function(switcher, textarea) {
      var preview_box;

      preview_box = $(document.createElement("div")).attr("id", "preview");
      preview_box.addClass("markdown_body");
      $(textarea).after(preview_box);
      preview_box.hide();
      $(".edit a", switcher).click(function() {
        $(".preview", switcher).removeClass("active");
        $(this).parent().addClass("active");
        $(preview_box).hide();
        $(textarea).show();
        return false;
      });
      return $(".preview a", switcher).click(function() {
        $(".edit", switcher).removeClass("active");
        $(this).parent().addClass("active");
        $(preview_box).show();
        $(textarea).hide();
        Topics.preview($(textarea).val());
        return false;
      });
    },
    initCloseWarning: function(el, msg) {
      if (el.length === 0) {
        return false;
      }
      if (!msg) {
        msg = "离开本页面将丢失未保存页面!";
      }
      $("input[type=submit]").click(function() {
        return $(window).unbind("beforeunload");
      });
      return el.change(function() {
        if (el.val().length > 0) {
          return $(window).bind("beforeunload", function(e) {
            if ($.browser.msie) {
              return e.returnValue = msg;
            } else {
              return msg;
            }
          });
        } else {
          return $(window).unbind("beforeunload");
        }
      });
    },
    favorite: function(el) {
      var hash, topic_id;

      topic_id = $(el).data("id");
      if ($(el).hasClass("small_bookmarked")) {
        hash = {
          type: "unfavorite"
        };
        $.ajax({
          url: "/topics/" + topic_id + "/favorite",
          data: hash,
          type: "POST"
        });
        $(el).attr("title", "收藏");
        $(el).attr("class", "icon small_bookmark");
      } else {
        $.post("/topics/" + topic_id + "/favorite");
        $(el).attr("title", "取消收藏");
        $(el).attr("class", "icon small_bookmarked");
      }
      return false;
    },
    follow: function(el) {
      var followed, topic_id;

      topic_id = $(el).data("id");
      followed = $(el).data("followed");
      if (followed) {
        $.ajax({
          url: "/topics/" + topic_id + "/unfollow",
          type: "POST"
        });
        $(el).data("followed", false);
        $("i", el).attr("class", "icon small_follow");
      } else {
        $.ajax({
          url: "/topics/" + topic_id + "/follow",
          type: "POST"
        });
        $(el).data("followed", true);
        $("i", el).attr("class", "icon small_followed");
      }
      return false;
    },
    submitTextArea: function(el) {
      if ($(el.target).val().trim().length > 0) {
        $("#reply > form").submit();
      }
      return false;
    },
    appendCodesFromHint: function(language) {
      var before_text, caret_pos, prefix_break, source, src_merged, txtBox;

      if (language == null) {
        language = '';
      }
      txtBox = $(".topic_editor");
      caret_pos = txtBox.caret('pos');
      prefix_break = "";
      if (txtBox.val().length > 0) {
        prefix_break = "\n";
      }
      src_merged = "" + prefix_break + "```" + language + "\n\n```\n";
      source = txtBox.val();
      before_text = source.slice(0, caret_pos);
      txtBox.val(before_text + src_merged + source.slice(caret_pos + 1, source.count));
      txtBox.caret('pos', caret_pos + src_merged.length - 5);
      return txtBox.focus();
    },
    init: function() {
      var bodyEl, k, logins, matchResult, v;

      bodyEl = $("body");
      Topics.initCloseWarning($("textarea.closewarning"));
      $("textarea").bind("keydown", "ctrl+return", function(el) {
        return Topics.submitTextArea(el);
      });
      $("textarea").bind("keydown", "Meta+return", function(el) {
        return Topics.submitTextArea(el);
      });
      $("textarea").autogrow();
      Topics.initUploader();
      $("a.at_floor").on('click', function(e) {
        var floor;

        floor = $(this).data('floor');
        return Topics.gotoFloor(floor);
      });
      matchResult = window.location.hash.match(/^#reply(\d+)$/);
      if (matchResult != null) {
        Topics.highlightReply($("#reply" + matchResult[1]));
      }
      $("a.small_reply").on('click', function() {
        return Topics.reply($(this).data("floor"), $(this).attr("data-login"));
      });
      Topics.hookPreview($(".editor_toolbar"), $(".topic_editor"));
      $("a.insert_code").on("click", function() {
        return Topics.appendCodesFromHint($(this).data('content') || $(this).attr('id'));
      });
      bodyEl.bind("keydown", "m", function(el) {
        return $('#markdown_help_tip_modal').modal({
          keyboard: true,
          backdrop: true,
          show: true
        });
      });
      logins = App.scanLogins($("#topic_show .leader a[data-author]"));
      $.extend(logins, App.scanLogins($('#replies span.name a')));
      logins = (function() {
        var _results;

        _results = [];
        for (k in logins) {
          v = logins[k];
          _results.push({
            login: k,
            name: v,
            search: "" + k + " " + v
          });
        }
        return _results;
      })();
      App.atReplyable("textarea", logins);
      return $("body.topics-controller.new-action #topic_title").focus();
    }
  };

  $(document).ready(function() {
    var _ref;

    if ((_ref = $('body').data('controller-name')) === 'topics' || _ref === 'replies') {
      return Topics.init();
    }
  });

}).call(this);
