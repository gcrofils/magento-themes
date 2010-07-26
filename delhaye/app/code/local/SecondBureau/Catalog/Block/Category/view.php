<?php
class SecondBureau_Catalog_Block_Category_View extends Mage_Catalog_Block_Category_View
{
 public function getPopularProductHtml()
 {
 	return $this->getBlockHtml('product_popular');
 }
 }
?>