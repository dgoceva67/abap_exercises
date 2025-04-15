*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_connection definition.

  public section.
  protected section.
  private section.

    TYPES: BEGIN OF st_details,
        DepartureAirport TYPE /dmo/airport_from_id,
        DestinationAirport TYPE /dmo/airport_to_id,
        AirlineName TYPE /dmo/carrier_id,
    END OF st_details.

endclass.

class lcl_connection implementation.

endclass.
