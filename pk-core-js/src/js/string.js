// TODO: Ugly hakish version, generalize and refactor!
PK.formatNumber = function(v, pres)
{
  if(pres === undefined)
    pres = 4;

  if (pres == 4)
  {
    if (v < 10) return "000" + v
    if (v < 100) return "00" + v
    if (v < 1000) return "0" + v
    if (v >= 10000)
    {
      CRITICAL_ERROR("Can't format big number!")
      return v
    }
  }
  else if (pres == 3)
  {
    if (v < 10) return "00" + v;
    if (v < 100) return "0" + v;
    if (v >= 1000)
    {
      CRITICAL_ERROR("Can't format big number!")
      return v
    }
  }
  else if (pres == 2)
  {
    if (v < 10) return "0" + v;
    if (v >= 100)
    {
      CRITICAL_ERROR("Can't format big number!")
      return v
    }
  }

  return v;
};


// Based on http://javascript.crockford.com/remedial.html
PK.entityify_and_escape_quotes = function (s)
{
  if(typeof(s) == "number")
    return s
  return s.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;")
}

// TODO: Note:
//   1. 's' must contain no separators!
//   2. Very non-optimal, reduce to one iteration
PK.split_using_placeholders = function(s, keys)
{
  var SEPARATOR = '{%_SEP_%}'

  var num_placehoders = 0, placeholder_found = true

  while (true)
  {
    num_placehoders++
    var placeholder = '${' + num_placehoders + '}'
    if( s.indexOf(placeholder) < 0 )
      break
    s = s.replace(placeholder, SEPARATOR + placeholder + SEPARATOR)
  }
  num_placehoders--

  if(keys)
  {
    for (var i = 0; i < keys.length; i++)
    {
      var placeholder = '${' + keys[i] + '}'
      if( s.indexOf(placeholder) < 0 )
        break
      s = s.replace(placeholder, SEPARATOR + placeholder + SEPARATOR)
    }
  }

  var splitted = s.split(SEPARATOR)

  var result = []
  for(var i = 0; i < splitted.length; i++)
  {
    if (splitted[i].match(/\$\{\d+\}/g))
    {
      result.push(Number(splitted[i].replace(/[\$\{\}]/g, "")))
    }
    else if (splitted[i] != "")
    {
      result.push(splitted[i])
    }

  }

  return result
}