//-----------------------------------------------------------------------------
// error_window.js: Slightly customized error window (not a member of our control hierarchy)
//-----------------------------------------------------------------------------

PKEngine.initialize_error_window = function ()
{
  if (PK.check_is_image_loaded($('#error_window_bg')[0]) &&
    PK.check_is_image_loaded($('#error_label')[0]) &&
    PK.check_is_image_loaded($('#spacer_top')[0]) &&
    PK.check_is_image_loaded($('#spacer_bottom')[0]) &&
    PK.check_is_image_loaded($('#close_button')[0]))
  {
    $('.errorWindowInner').show();
  }
}

PKEngine.ERROR = function(text)
{
  var now = new Date(PK.Time.get_current_timestamp());
  var cur_date = now.getDate() + '-' + (now.getMonth() + 1) + '-' + now.getFullYear();
  var date = '[' + cur_date + ' ' + now.toLocaleTimeString() + ']';

  // TODO: #3264 Uncomment or remove - get_common_post_data from PKHB
//  var text = date + ' user: ' + PKHB.get_common_post_data() + '<br>' + text;

  CRITICAL_ERROR(text);
}