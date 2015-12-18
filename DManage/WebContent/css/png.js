$(function() {
    $("#kw").live("focus", function() {
        var v = $.trim($(this).val());
        if (v == '请输入应用名称') {
            $(this).addClass("kwfocuscolor").val('');
        }
    })

    $("#kw").live("blur", function() {
        $(this).attr("class", "kwprecolor");
        var v = $.trim($(this).val());
        if (v.length <= 0) {
            $(this).val('请输入应用名称');
        } else if (v != '请输入应用名称') {
            $(this).attr("class", "kwfocuscolor");
        }
    })

    //#getstore


    //历史下载表格导航
    $(".boxnav > ul > li > a").click(function(event) {
        //event.preventDefault();
        $(".boxnav > ul > li > a").removeClass();
        $(this).addClass("current");
    })



    $(".pos_head span").click(function() {
        $(this).closest(".pos_black").hide(100);
    })


    //显示相关推荐
    $(".cell_post_").click(function() {
        $(this).next().show(100);
    })


    $("#formToget").submit(function(event) {
        event.preventDefault();
        var kw = $("#kw").val();
        if (kw != "请输入应用名称") {
            window.top.location.href = 'Get.aspx?kw=' + encodeURI(kw);
        }

        $("#kw").focus();
    })


    //调查TIPS

    $("#Submitfaceback").click(function(event) {
        //$("from").serialize();

        var status = $("input[name='show']:checked").val();
        var content = $("#txtContent").val();

        $.ajax({
            url: '../Services/WriteSurvey.ashx',
            type: 'post',
            dataType: 'json',
            data: {
                status: status,
                content: content
            },
            beforeSend: function() {

            },
            error: function() { },
            success: function(data) {
                if (data) {
                    $("#test_con").hide(100);
                    $(".poplayer").hide(0);

                    $("#dialog-modal_success").dialog("destroy");
                    $("#dialog-modal_success").dialog({
                        height: 120,
                        modal: true
                    });

                    $(".ui-widget-overlay,.ui-dialog").remove();

                } else {

                    $("#test_con").hide(100);
                    $(".poplayer").hide(0);

                    $("#dialog:ui-dialog").dialog("destroy");
                    $("#dialog-modal").dialog({
                        height: 120,
                        modal: true
                    });

                    $(".ui-widget-overlay,.ui-dialog").remove();
                }
            }
        })


    })

    $("#writesurvey").click(function() {
        $('.poplayer').css({ 'height': $(document).height(), 'display': 'block' });
        $('.poplayer').animate({ opacity: 0.5 }, 0);
        $("#test_con").show(100);
    })
    $("#inputclose").click(function() {
        $("#test_con").hide(100);
        $(".poplayer").hide(0);
    })

})


