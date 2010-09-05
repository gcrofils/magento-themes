/**
 * Raptor
 *
 * NOTICE OF LICENSE
 * 
 * @category    Raptor
 * @package     js
 * @copyright   Copyright (c) 2010 Raptor Inc. (http://www.raptorcommerce.com)
 */

/**
 * legacy code
 */
function toggleMenu(el, over)
{
    if (over) {
        Element.addClassName(el, 'over');
    }
    else {
        Element.removeClassName(el, 'over');
    }
}
