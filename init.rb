MAGETHEME_ROOT = File.expand_path(File.dirname(__FILE__))
MAGE_THEMES = File.join(MAGETHEME_ROOT, 'themes')
$LOAD_PATH.unshift(File.join(MAGETHEME_ROOT, 'lib'))
require 'magetheme'
