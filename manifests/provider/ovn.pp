# Configures the octavia ovn driver
#
# == Parameters
#
# [*ovn_nb_connection*]
#   (optional) The connection string for the OVN_Northbound OVSDB.
#   Defaults to $::os_service_default
#
# [*ovn_nb_private_key*]
#   (optional) The PEM file with private key for SSL connection to OVN-NB-DB
#   Defaults to $::os_service_default
#
# [*ovn_nb_certificate*]
#   (optional) The PEM file with certificate that certifies the private
#   key specified in ovn_nb_private_key
#   Defaults to $::os_service_default
#
# [*ovn_nb_ca_cert*]
#   (optional) The PEM file with CA certificate that OVN should use to
#   verify certificates presented to it by SSL peers
#   Defaults to $::os_service_default
#
class octavia::provider::ovn (
  $ovn_nb_connection  = $::os_service_default,
  $ovn_nb_private_key = $::os_service_default,
  $ovn_nb_certificate = $::os_service_default,
  $ovn_nb_ca_cert     = $::os_service_default
) inherits octavia::params {

  include octavia::deps

  # For backward compatibility
  $ovn_nb_connection_real = pick($::octavia::api::ovn_nb_connection, $ovn_nb_connection)

  octavia_ovn_provider_config {
    'ovn/ovn_nb_connection':  value => $ovn_nb_connection_real;
    'ovn/ovn_nb_private_key': value => $ovn_nb_private_key;
    'ovn/ovn_nb_certificate': value => $ovn_nb_certificate;
    'ovn/ovn_nb_ca_cert':     value => $ovn_nb_ca_cert;
  }
}
