// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require_tree .


// 将用户输入的内容转为数字
function parseToInt(value) {
  // 去掉用户输入的所有非数字字符
  while (value.match(/[^\d]/)) {
    value = value.replace(/[^\d]/, '');
  }
  // 将剩下的合法内容转为数字
  return parseInt(value == '' ? 0 : value);
}

$(document).on('turbolinks:load', function() {
  /*增加数量*/
  $("#quantity-plus").click(function(e) {
    var num = parseInt($("#quantity-input").val()) + 1;
    $("#quantity-minus").removeClass("disabled");
    $("#quantity-input").val(num);
    e.preventDefault();
  });

  /*减少数量*/
  $("#quantity-minus").click(function(e) {
    var num = parseInt($("#quantity-input").val());
    if (num > 1) {
      $("#quantity-input").val(num -= 1);
      $("#quantity-plus").removeClass("disabled");
    }
    if (num <= 1) {
      $("#quantity-minus").addClass("disabled");
    }
    e.preventDefault();
  });

  /*商品数量输入控制*/
  $('#quantity-input').on('input', function(e) {
    var max = parseInt($(this).attr('max'));
    var num = parseToInt($(this).val());
    if (num <= 1) {
      $(this).val('1');
      $("#quantity-minus").addClass('disabled');
    } else {
      $("#quantity-minus").removeClass('disabled');
    }
    // 限制输入数量不大于名额
    if (num >= max) {
      $(this).val(max);
      $("#quantity-plus").addClass('disabled');
    } else {
      $(this).val(num);
      $("#quantity-plus").removeClass('disabled');
    }
  }).on('blur', function(e) {
    // 当用户输入0或空白时，将数量设为1
    var value = $(this).val();
    if (value == '' || value == '0') {
      $(this).val('1');
    }
  });

});
