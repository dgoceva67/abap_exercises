@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking data'
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_RAP_BOOKING_U_101 as projection on ZI_RAP_BOOKING_U_101
{
    @Search.defaultSearchElement: true
    key TravelID,
    @Search.defaultSearchElement: true
    key BookingID,
    BookingDate,
    @Consumption.valueHelpDefinition: [ { entity: { name:     '/DMO/I_Customer',
                                                      element:     'CustomerID' } } ]
    CustomerID,
        @Consumption.valueHelpDefinition: [ { entity: { name:     '/DMO/I_Flight',
                                                      element:     'ConnectionID' } ,
                                              additionalBinding: [ { localElement: 'FlightDate',
                                                                     element:      'FlightDate',
                                                                usage: #RESULT }, 
                                                              { localElement: 'CarrierID',
                                                                     element: 'AirlineID',
                                                                       usage: #RESULT }, 
                                                              { localElement: 'FlightPrice',
                                                                     element: 'Price',
                                                                       usage: #RESULT }, 
                                                              { localElement: 'CurrencyCode',
                                                                     element: 'CurrencyCode',
                                                                       usage: #RESULT } ] 
                                         } ]
    CarrierID,
    ConnectionID,
    FlightDate,
    FlightPrice,
    @Consumption.valueHelpDefinition: [ { entity: { name:     'I_Currency',
                                                      element:     'Currency' } } ]
    CurrencyCode,
    /* Associations */
    _Carrier,
    _Connection,
    _Customer,
    _Flight,
    _Travel : redirected to parent ZC_RAP_TRAVEL_U_101
}
