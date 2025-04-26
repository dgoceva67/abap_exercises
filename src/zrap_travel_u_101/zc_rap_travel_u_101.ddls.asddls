@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Travel data'
@Search.searchable: true
@Metadata.allowExtensions: true
define root view entity ZC_RAP_TRAVEL_U_101 as projection on ZI_RAP_TRAVEL_U_101
{
    key TravelID,
    @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Agency', element: 'AgencyID' } } ]
    @Search.defaultSearchElement: true
    AgencyID,
    @Consumption.valueHelpDefinition: [ { entity: { name: '/DMO/I_Customer', element: 'CustomerID' } } ]
    @Search.defaultSearchElement: true
    CustomerID,
    BeginDate,
    EndDate,
    BookingFee,
    TotalPrice,
    @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Currency', element: 'CurrencyID' } } ]
    CurrencyCode,
    Description,
    Status,
    Createdby,
    Createdat,
    Lastchangedby,
    Lastchangedat,
    /* Associations */
    _Agency,
    _Booking : redirected to composition child ZC_RAP_BOOKING_U_101,
    _Currency,
    _Customer
}
