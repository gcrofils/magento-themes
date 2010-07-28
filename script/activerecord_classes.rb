class AdminAssert < ActiveRecord::Base 
 set_primary_key "assert_id" 
end
class AdminRole < ActiveRecord::Base 
 set_primary_key "role_id" 
end
class AdminRule < ActiveRecord::Base 
 set_primary_key "rule_id" 
end
class AdminUser < ActiveRecord::Base 
 set_primary_key "user_id" 
end
class AdminnotificationInbox < ActiveRecord::Base 
 set_primary_key "notification_id" 
end
class ApiAssert < ActiveRecord::Base 
 set_primary_key "assert_id" 
end
class ApiRole < ActiveRecord::Base 
 set_primary_key "role_id" 
end
class ApiRule < ActiveRecord::Base 
 set_primary_key "rule_id" 
end
class ApiUser < ActiveRecord::Base 
 set_primary_key "user_id" 
end
class AwBlog < ActiveRecord::Base 
 set_primary_key "post_id" 
end
class AwBlogCat < ActiveRecord::Base 
 set_primary_key "cat_id" 
end
class AwBlogComment < ActiveRecord::Base 
 set_primary_key "comment_id" 
end
class AwBlogTags < ActiveRecord::Base 
 set_primary_key "id" 
end
class CatalogCategoryEntity < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class CatalogCategoryEntityDatetime < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogCategoryEntityDecimal < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogCategoryEntityInt < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogCategoryEntityText < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogCategoryEntityVarchar < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogCategoryFlatStore1 < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class CatalogCompareItem < ActiveRecord::Base 
 set_primary_key "catalog_compare_item_id" 
end
class CatalogEavAttribute < ActiveRecord::Base 
 set_primary_key "attribute_id" 
end
class CatalogProductBundleOption < ActiveRecord::Base 
 set_primary_key "option_id" 
end
class CatalogProductBundleOptionValue < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductBundleSelection < ActiveRecord::Base 
 set_primary_key "selection_id" 
end
class CatalogProductEntity < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class CatalogProductEntityDatetime < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductEntityDecimal < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductEntityGallery < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductEntityInt < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductEntityMediaGallery < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductEntityText < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductEntityTierPrice < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductEntityVarchar < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductFlat1 < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class CatalogProductIndexWebsite < ActiveRecord::Base 
 set_primary_key "website_id" 
end
class CatalogProductLink < ActiveRecord::Base 
 set_primary_key "link_id" 
end
class CatalogProductLinkAttribute < ActiveRecord::Base 
 set_primary_key "product_link_attribute_id" 
end
class CatalogProductLinkAttributeDecimal < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductLinkAttributeInt < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductLinkAttributeVarchar < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductLinkType < ActiveRecord::Base 
 set_primary_key "link_type_id" 
end
class CatalogProductOption < ActiveRecord::Base 
 set_primary_key "option_id" 
end
class CatalogProductOptionPrice < ActiveRecord::Base 
 set_primary_key "option_price_id" 
end
class CatalogProductOptionTitle < ActiveRecord::Base 
 set_primary_key "option_title_id" 
end
class CatalogProductOptionTypePrice < ActiveRecord::Base 
 set_primary_key "option_type_price_id" 
end
class CatalogProductOptionTypeTitle < ActiveRecord::Base 
 set_primary_key "option_type_title_id" 
end
class CatalogProductOptionTypeValue < ActiveRecord::Base 
 set_primary_key "option_type_id" 
end
class CatalogProductSuperAttribute < ActiveRecord::Base 
 set_primary_key "product_super_attribute_id" 
end
class CatalogProductSuperAttributeLabel < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductSuperAttributePricing < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CatalogProductSuperLink < ActiveRecord::Base 
 set_primary_key "link_id" 
end
class CatalogindexAggregation < ActiveRecord::Base 
 set_primary_key "aggregation_id" 
end
class CatalogindexAggregationTag < ActiveRecord::Base 
 set_primary_key "tag_id" 
end
class CatalogindexMinimalPrice < ActiveRecord::Base 
 set_primary_key "index_id" 
end
class CataloginventoryStock < ActiveRecord::Base 
 set_primary_key "stock_id" 
end
class CataloginventoryStockItem < ActiveRecord::Base 
 set_primary_key "item_id" 
end
class Catalogrule < ActiveRecord::Base 
 set_primary_key "rule_id" 
end
class CatalogruleAffectedProduct < ActiveRecord::Base 
 set_primary_key "product_id" 
end
class CatalogruleProduct < ActiveRecord::Base 
 set_primary_key "rule_product_id" 
end
class CatalogruleProductPrice < ActiveRecord::Base 
 set_primary_key "rule_product_price_id" 
end
class CatalogsearchQuery < ActiveRecord::Base 
 set_primary_key "query_id" 
end
class CheckoutAgreement < ActiveRecord::Base 
 set_primary_key "agreement_id" 
end
class CmsBlock < ActiveRecord::Base 
 set_primary_key "block_id" 
end
class CmsPage < ActiveRecord::Base 
 set_primary_key "page_id" 
end
class CoreCache < ActiveRecord::Base 
 set_primary_key "id" 
end
class CoreCacheOption < ActiveRecord::Base 
 set_primary_key "code" 
end
class CoreConfigData < ActiveRecord::Base 
 set_primary_key "config_id" 
end
class CoreEmailTemplate < ActiveRecord::Base 
 set_primary_key "template_id" 
end
class CoreFlag < ActiveRecord::Base 
 set_primary_key "flag_id" 
end
class CoreLayoutLink < ActiveRecord::Base 
 set_primary_key "layout_link_id" 
end
class CoreLayoutUpdate < ActiveRecord::Base 
 set_primary_key "layout_update_id" 
end
class CoreResource < ActiveRecord::Base 
 set_primary_key "code" 
end
class CoreSession < ActiveRecord::Base 
 set_primary_key "session_id" 
end
class CoreStore < ActiveRecord::Base 
 set_primary_key "store_id" 
end
class CoreStoreGroup < ActiveRecord::Base 
 set_primary_key "group_id" 
end
class CoreTranslate < ActiveRecord::Base 
 set_primary_key "key_id" 
end
class CoreUrlRewrite < ActiveRecord::Base 
 set_primary_key "url_rewrite_id" 
end
class CoreVariable < ActiveRecord::Base 
 set_primary_key "variable_id" 
end
class CoreVariableValue < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CoreWebsite < ActiveRecord::Base 
 set_primary_key "website_id" 
end
class CouponAggregated < ActiveRecord::Base 
 set_primary_key "id" 
end
class CouponAggregatedOrder < ActiveRecord::Base 
 set_primary_key "id" 
end
class CronSchedule < ActiveRecord::Base 
 set_primary_key "schedule_id" 
end
class CustomerAddressEntity < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class CustomerAddressEntityDatetime < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerAddressEntityDecimal < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerAddressEntityInt < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerAddressEntityText < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerAddressEntityVarchar < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerEavAttribute < ActiveRecord::Base 
 set_primary_key "attribute_id" 
end
class CustomerEntity < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class CustomerEntityDatetime < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerEntityDecimal < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerEntityInt < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerEntityText < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerEntityVarchar < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class CustomerGroup < ActiveRecord::Base 
 set_primary_key "customer_group_id" 
end
class DataflowBatch < ActiveRecord::Base 
 set_primary_key "batch_id" 
end
class DataflowBatchExport < ActiveRecord::Base 
 set_primary_key "batch_export_id" 
end
class DataflowBatchImport < ActiveRecord::Base 
 set_primary_key "batch_import_id" 
end
class DataflowImportData < ActiveRecord::Base 
 set_primary_key "import_id" 
end
class DataflowProfile < ActiveRecord::Base 
 set_primary_key "profile_id" 
end
class DataflowProfileHistory < ActiveRecord::Base 
 set_primary_key "history_id" 
end
class DataflowSession < ActiveRecord::Base 
 set_primary_key "session_id" 
end
class DesignChange < ActiveRecord::Base 
 set_primary_key "design_change_id" 
end
class DirectoryCountry < ActiveRecord::Base 
 set_primary_key "country_id" 
end
class DirectoryCountryFormat < ActiveRecord::Base 
 set_primary_key "country_format_id" 
end
class DirectoryCountryRegion < ActiveRecord::Base 
 set_primary_key "region_id" 
end
class DownloadableLink < ActiveRecord::Base 
 set_primary_key "link_id" 
end
class DownloadableLinkPrice < ActiveRecord::Base 
 set_primary_key "price_id" 
end
class DownloadableLinkPurchased < ActiveRecord::Base 
 set_primary_key "purchased_id" 
end
class DownloadableLinkPurchasedItem < ActiveRecord::Base 
 set_primary_key "item_id" 
end
class DownloadableLinkTitle < ActiveRecord::Base 
 set_primary_key "title_id" 
end
class DownloadableSample < ActiveRecord::Base 
 set_primary_key "sample_id" 
end
class DownloadableSampleTitle < ActiveRecord::Base 
 set_primary_key "title_id" 
end
class EavAttribute < ActiveRecord::Base 
 set_primary_key "attribute_id" 
end
class EavAttributeGroup < ActiveRecord::Base 
 set_primary_key "attribute_group_id" 
end
class EavAttributeLabel < ActiveRecord::Base 
 set_primary_key "attribute_label_id" 
end
class EavAttributeOption < ActiveRecord::Base 
 set_primary_key "option_id" 
end
class EavAttributeOptionValue < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class EavAttributeSet < ActiveRecord::Base 
 set_primary_key "attribute_set_id" 
end
class EavEntity < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class EavEntityAttribute < ActiveRecord::Base 
 set_primary_key "entity_attribute_id" 
end
class EavEntityDatetime < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class EavEntityDecimal < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class EavEntityInt < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class EavEntityStore < ActiveRecord::Base 
 set_primary_key "entity_store_id" 
end
class EavEntityText < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class EavEntityType < ActiveRecord::Base 
 set_primary_key "entity_type_id" 
end
class EavEntityVarchar < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class EavFormElement < ActiveRecord::Base 
 set_primary_key "element_id" 
end
class EavFormFieldset < ActiveRecord::Base 
 set_primary_key "fieldset_id" 
end
class EavFormType < ActiveRecord::Base 
 set_primary_key "type_id" 
end
class GiftMessage < ActiveRecord::Base 
 set_primary_key "gift_message_id" 
end
class GooglebaseAttributes < ActiveRecord::Base 
 set_primary_key "id" 
end
class GooglebaseItems < ActiveRecord::Base 
 set_primary_key "item_id" 
end
class GooglebaseTypes < ActiveRecord::Base 
 set_primary_key "type_id" 
end
class GooglecheckoutApiDebug < ActiveRecord::Base 
 set_primary_key "debug_id" 
end
class GoogleoptimizerCode < ActiveRecord::Base 
 set_primary_key "code_id" 
end
class IndexEvent < ActiveRecord::Base 
 set_primary_key "event_id" 
end
class IndexProcess < ActiveRecord::Base 
 set_primary_key "process_id" 
end
class LogCustomer < ActiveRecord::Base 
 set_primary_key "log_id" 
end
class LogQuote < ActiveRecord::Base 
 set_primary_key "quote_id" 
end
class LogSummary < ActiveRecord::Base 
 set_primary_key "summary_id" 
end
class LogSummaryType < ActiveRecord::Base 
 set_primary_key "type_id" 
end
class LogUrl < ActiveRecord::Base 
 set_primary_key "url_id" 
end
class LogUrlInfo < ActiveRecord::Base 
 set_primary_key "url_id" 
end
class LogVisitor < ActiveRecord::Base 
 set_primary_key "visitor_id" 
end
class LogVisitorInfo < ActiveRecord::Base 
 set_primary_key "visitor_id" 
end
class LogVisitorOnline < ActiveRecord::Base 
 set_primary_key "visitor_id" 
end
class NewsletterProblem < ActiveRecord::Base 
 set_primary_key "problem_id" 
end
class NewsletterQueue < ActiveRecord::Base 
 set_primary_key "queue_id" 
end
class NewsletterQueueLink < ActiveRecord::Base 
 set_primary_key "queue_link_id" 
end
class NewsletterSubscriber < ActiveRecord::Base 
 set_primary_key "subscriber_id" 
end
class NewsletterTemplate < ActiveRecord::Base 
 set_primary_key "template_id" 
end
class PaygateAuthorizenetDebug < ActiveRecord::Base 
 set_primary_key "debug_id" 
end
class PaypalApiDebug < ActiveRecord::Base 
 set_primary_key "debug_id" 
end
class PaypalSettlementReport < ActiveRecord::Base 
 set_primary_key "report_id" 
end
class PaypalSettlementReportRow < ActiveRecord::Base 
 set_primary_key "row_id" 
end
class PaypalukApiDebug < ActiveRecord::Base 
 set_primary_key "debug_id" 
end
class Poll < ActiveRecord::Base 
 set_primary_key "poll_id" 
end
class PollAnswer < ActiveRecord::Base 
 set_primary_key "answer_id" 
end
class PollVote < ActiveRecord::Base 
 set_primary_key "vote_id" 
end
class ProductAlertPrice < ActiveRecord::Base 
 set_primary_key "alert_price_id" 
end
class ProductAlertStock < ActiveRecord::Base 
 set_primary_key "alert_stock_id" 
end
class Rating < ActiveRecord::Base 
 set_primary_key "rating_id" 
end
class RatingEntity < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class RatingOption < ActiveRecord::Base 
 set_primary_key "option_id" 
end
class RatingOptionVote < ActiveRecord::Base 
 set_primary_key "vote_id" 
end
class RatingOptionVoteAggregated < ActiveRecord::Base 
 set_primary_key "primary_id" 
end
class ReportComparedProductIndex < ActiveRecord::Base 
 set_primary_key "index_id" 
end
class ReportEvent < ActiveRecord::Base 
 set_primary_key "event_id" 
end
class ReportEventTypes < ActiveRecord::Base 
 set_primary_key "event_type_id" 
end
class ReportViewedProductIndex < ActiveRecord::Base 
 set_primary_key "index_id" 
end
class Review < ActiveRecord::Base 
 set_primary_key "review_id" 
end
class ReviewDetail < ActiveRecord::Base 
 set_primary_key "detail_id" 
end
class ReviewEntity < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class ReviewEntitySummary < ActiveRecord::Base 
 set_primary_key "primary_id" 
end
class ReviewStatus < ActiveRecord::Base 
 set_primary_key "status_id" 
end
class SalesBestsellersAggregatedDaily < ActiveRecord::Base 
 set_primary_key "id" 
end
class SalesBestsellersAggregatedMonthly < ActiveRecord::Base 
 set_primary_key "id" 
end
class SalesBestsellersAggregatedYearly < ActiveRecord::Base 
 set_primary_key "id" 
end
class SalesBillingAgreement < ActiveRecord::Base 
 set_primary_key "agreement_id" 
end
class SalesFlatCreditmemo < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatCreditmemoComment < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatCreditmemoGrid < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatCreditmemoItem < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatInvoice < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatInvoiceComment < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatInvoiceGrid < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatInvoiceItem < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatOrder < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatOrderAddress < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatOrderGrid < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatOrderItem < ActiveRecord::Base 
 set_primary_key "item_id" 
end
class SalesFlatOrderPayment < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatOrderStatusHistory < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatQuote < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatQuoteAddress < ActiveRecord::Base 
 set_primary_key "address_id" 
end
class SalesFlatQuoteAddressItem < ActiveRecord::Base 
 set_primary_key "address_item_id" 
end
class SalesFlatQuoteItem < ActiveRecord::Base 
 set_primary_key "item_id" 
end
class SalesFlatQuoteItemOption < ActiveRecord::Base 
 set_primary_key "option_id" 
end
class SalesFlatQuotePayment < ActiveRecord::Base 
 set_primary_key "payment_id" 
end
class SalesFlatQuoteShippingRate < ActiveRecord::Base 
 set_primary_key "rate_id" 
end
class SalesFlatShipment < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatShipmentComment < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatShipmentGrid < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatShipmentItem < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesFlatShipmentTrack < ActiveRecord::Base 
 set_primary_key "entity_id" 
end
class SalesInvoicedAggregated < ActiveRecord::Base 
 set_primary_key "id" 
end
class SalesInvoicedAggregatedOrder < ActiveRecord::Base 
 set_primary_key "id" 
end
class SalesOrderAggregatedCreated < ActiveRecord::Base 
 set_primary_key "id" 
end
class SalesOrderTax < ActiveRecord::Base 
 set_primary_key "tax_id" 
end
class SalesPaymentTransaction < ActiveRecord::Base 
 set_primary_key "transaction_id" 
end
class SalesRecurringProfile < ActiveRecord::Base 
 set_primary_key "profile_id" 
end
class SalesRecurringProfileOrder < ActiveRecord::Base 
 set_primary_key "link_id" 
end
class SalesRefundedAggregated < ActiveRecord::Base 
 set_primary_key "id" 
end
class SalesRefundedAggregatedOrder < ActiveRecord::Base 
 set_primary_key "id" 
end
class SalesShippingAggregated < ActiveRecord::Base 
 set_primary_key "id" 
end
class SalesShippingAggregatedOrder < ActiveRecord::Base 
 set_primary_key "id" 
end
class Salesrule < ActiveRecord::Base 
 set_primary_key "rule_id" 
end
class SalesruleCoupon < ActiveRecord::Base 
 set_primary_key "coupon_id" 
end
class SalesruleCustomer < ActiveRecord::Base 
 set_primary_key "rule_customer_id" 
end
class SalesruleLabel < ActiveRecord::Base 
 set_primary_key "label_id" 
end
class SendfriendLog < ActiveRecord::Base 
 set_primary_key "log_id" 
end
class ShippingTablerate < ActiveRecord::Base 
 set_primary_key "pk" 
end
class Sitemap < ActiveRecord::Base 
 set_primary_key "sitemap_id" 
end
class Tag < ActiveRecord::Base 
 set_primary_key "tag_id" 
end
class TagRelation < ActiveRecord::Base 
 set_primary_key "tag_relation_id" 
end
class TaxCalculationRate < ActiveRecord::Base 
 set_primary_key "tax_calculation_rate_id" 
end
class TaxCalculationRateTitle < ActiveRecord::Base 
 set_primary_key "tax_calculation_rate_title_id" 
end
class TaxCalculationRule < ActiveRecord::Base 
 set_primary_key "tax_calculation_rule_id" 
end
class TaxClass < ActiveRecord::Base 
 set_primary_key "class_id" 
end
class TaxOrderAggregatedCreated < ActiveRecord::Base 
 set_primary_key "id" 
end
class WeeeTax < ActiveRecord::Base 
 set_primary_key "value_id" 
end
class Widget < ActiveRecord::Base 
 set_primary_key "widget_id" 
end
class WidgetInstance < ActiveRecord::Base 
 set_primary_key "instance_id" 
end
class WidgetInstancePage < ActiveRecord::Base 
 set_primary_key "page_id" 
end
class Wiogmap < ActiveRecord::Base 
 set_primary_key "loc_id" 
end
class Wishlist < ActiveRecord::Base 
 set_primary_key "wishlist_id" 
end
class WishlistItem < ActiveRecord::Base 
 set_primary_key "wishlist_item_id" 
end

