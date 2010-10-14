<?php
/**
 * Magento Atos
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 *
 * @category   Mage
 * @package    Mage_Atos
 * @copyright  Signamarcheix Fabien - Groupe Reflect
 * @license    http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL 3.0)
 */
class Mage_Atos_Model_Method_Euro extends Mage_Atos_Model_Abstract
{
	private $_url = null;
	private $_message = null;
	private $_error = false;

    protected $_code  = 'atos_euro';
	
    protected $_formBlockType = 'atos/euro_form';
	protected $_infoBlockType = 'atos/euro_info';

    /*
     * Availability options
     */
    protected $_isGateway               = false;
    protected $_canAuthorize            = false;
    protected $_canCapture              = false;
    protected $_canCapturePartial       = false;
    protected $_canRefund               = false;
    protected $_canVoid                 = false;
    protected $_canUseInternal          = false;
    protected $_canUseCheckout          = true;
    protected $_canUseForMultishipping  = false;
	
    public function getCode()
	{
	    return $this->_code;
	}
	
	public function isAvailable($quote = null)
	{
	   	if (Mage::getSingleton('checkout/session')->getQuote()->getIsMultiShipping()) 
		{
            return false;
		} else {
		    return parent::isAvailable($quote);
		}
	}
		
    /**
     *  Form block description
     *
     *  @return	 object
     */
    public function createFormBlock($name)
    {
        $block = $this->getLayout()->createBlock($this->_formBlockType, $name);
        $block->setMethod($this->_code);
        $block->setPayment($this->getPayment());
        return $block;
    }
	
    /**
     *  @return	  string Return cancel URL
     */
    public function getCancelReturnUrl()
    {
        return Mage::getUrl('atos/euro/cancel');
    }
	
    /**
     *  Return URL for customer response
     *
     *  @return	  string Return customer URL
     */
    public function getNormalReturnUrl()
    {
        return Mage::getUrl('atos/euro/normal');
    }
	
    /**
     *  Return URL for automatic response
     *
     *  @return	  string Return automatic URL
     */
    public function getAutomaticReturnUrl()
    {
        return Mage::getUrl('atos/euro/automatic');
    }
	
    /**
     *  Return Order Place Redirect URL
     *
     *  @return	  string Order Redirect URL
     */
    public function getOrderPlaceRedirectUrl()
    {
        return Mage::getUrl('atos/euro/redirect');
	}
	
    public function callRequest()
    {
    	$quote = $this->getQuote();
		$customer = $quote->getCustomer();
		$billing = $quote->getCustomer()->getPrimaryBillingAddress();
    	$parameters = array(
		   'bin_request'   => $this->getBinRequest(),
		   'merchant_id'   => $this->getMerchantId(),
		   'payment_means' => '1EUROCOM,2',
		   'url' => array(
		              'cancel' => $this->getCancelReturnUrl(),
					  'normal' => $this->getNormalReturnUrl(),
					  'automatic' => $this->getAutomaticReturnUrl()
		            ),
		   //On récupère les informations clients pour les envoyer à 1euro.com
		   'command' => ' data="1EUROCOM_DATA='.$customer->getPrefix().'#'.$customer->getLastname().'#'.$customer->getFirstname().'#'.$billing->getStreet1().'#'.$billing->getStreet2().'#'.$billing->getStreet3().'#'.$billing->getPostcode().'#'.$billing->getCity().'#FR##'.$billing->getTelephone().'#0#0#12##1EU#WEB"'
		);
		$sips = $this->getApiRequest()->doRequest($parameters);
		
        if ($sips['error']) {
            $this->_error = true;
        } else {
	        $regs = array();
			
	        if (eregi('<form [^>]*action="([^"]*)"[^>]*>(.*)</form>', $sips['message'], $regs)) {
/*echo "EURO<br>";
Zend_Debug::dump($sips);
Zend_Debug::dump($regs);
exit;*/
                /*$data = explode ("!", $sips['output']);
                $this->_message = $data[3];*/
	            
	            $this->_url = $regs[1];
                $this->_message = $regs[2];
	            
	        } else {
	           $this->_error = true;
	           $this->_message = 'Call Bin Request Error - Check path to the file or command line for debug';
	        }
        }
    }
	
	public function getSystemUrl() 
	{	
	    return $this->_url;
	}
	
	public function getSystemMessage() 
	{
	    return $this->_message;
	}
	
    /**
     * Return merchant ID
     *
     * @return string
     */
    public function getMerchantId()
    {
	    return $this->getConfigData('merchant_id');
    }
	
    public function getPathfile()
    {
	    return $this->getConfigData('pathfile');
    }
	
    /**
     *  Return Atos bin file for request
     *
     *  @return	  string
     */
    public function getBinRequest()
    {
    	return $this->getConfigData('bin_request');
    }
	
    /**
     *  Return Atos bin file for response
     *
     *  @return	  string
     */
    public function getBinResponse()
    {
	    return $this->getConfigData('bin_response');
    }


    public function getCheckByIpAddress()
	{
	    return $this->getConfigData('check_ip_address');
	}
	
    /**
     *  Return new order status
     *
     *  @return	  string New order status
     */
    public function getNewOrderStatus()
    {
        return $this->getConfigData('order_status');
    }
}