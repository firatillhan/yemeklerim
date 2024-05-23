/* This file was generated by upb_generator from the input file:
 *
 *     envoy/config/listener/v3/udp_listener_config.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#include "upb/reflection/def.h"
#include "envoy/config/listener/v3/udp_listener_config.upbdefs.h"
#include "envoy/config/listener/v3/udp_listener_config.upb_minitable.h"

extern _upb_DefPool_Init envoy_config_core_v3_extension_proto_upbdefinit;
extern _upb_DefPool_Init envoy_config_core_v3_udp_socket_config_proto_upbdefinit;
extern _upb_DefPool_Init envoy_config_listener_v3_quic_config_proto_upbdefinit;
extern _upb_DefPool_Init udpa_annotations_status_proto_upbdefinit;
extern _upb_DefPool_Init udpa_annotations_versioning_proto_upbdefinit;
static const char descriptor[921] = {'\n', '2', 'e', 'n', 'v', 'o', 'y', '/', 'c', 'o', 'n', 'f', 'i', 'g', '/', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '/', 'v', 
'3', '/', 'u', 'd', 'p', '_', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '_', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'p', 'r', 'o', 
't', 'o', '\022', '\030', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', 
'.', 'v', '3', '\032', '$', 'e', 'n', 'v', 'o', 'y', '/', 'c', 'o', 'n', 'f', 'i', 'g', '/', 'c', 'o', 'r', 'e', '/', 'v', '3', 
'/', 'e', 'x', 't', 'e', 'n', 's', 'i', 'o', 'n', '.', 'p', 'r', 'o', 't', 'o', '\032', ',', 'e', 'n', 'v', 'o', 'y', '/', 'c', 
'o', 'n', 'f', 'i', 'g', '/', 'c', 'o', 'r', 'e', '/', 'v', '3', '/', 'u', 'd', 'p', '_', 's', 'o', 'c', 'k', 'e', 't', '_', 
'c', 'o', 'n', 'f', 'i', 'g', '.', 'p', 'r', 'o', 't', 'o', '\032', '*', 'e', 'n', 'v', 'o', 'y', '/', 'c', 'o', 'n', 'f', 'i', 
'g', '/', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '/', 'v', '3', '/', 'q', 'u', 'i', 'c', '_', 'c', 'o', 'n', 'f', 'i', 'g', 
'.', 'p', 'r', 'o', 't', 'o', '\032', '\035', 'u', 'd', 'p', 'a', '/', 'a', 'n', 'n', 'o', 't', 'a', 't', 'i', 'o', 'n', 's', '/', 
's', 't', 'a', 't', 'u', 's', '.', 'p', 'r', 'o', 't', 'o', '\032', '!', 'u', 'd', 'p', 'a', '/', 'a', 'n', 'n', 'o', 't', 'a', 
't', 'i', 'o', 'n', 's', '/', 'v', 'e', 'r', 's', 'i', 'o', 'n', 'i', 'n', 'g', '.', 'p', 'r', 'o', 't', 'o', '\"', '\216', '\003', 
'\n', '\021', 'U', 'd', 'p', 'L', 'i', 's', 't', 'e', 'n', 'e', 'r', 'C', 'o', 'n', 'f', 'i', 'g', '\022', '_', '\n', '\030', 'd', 'o', 
'w', 'n', 's', 't', 'r', 'e', 'a', 'm', '_', 's', 'o', 'c', 'k', 'e', 't', '_', 'c', 'o', 'n', 'f', 'i', 'g', '\030', '\005', ' ', 
'\001', '(', '\013', '2', '%', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', 
'3', '.', 'U', 'd', 'p', 'S', 'o', 'c', 'k', 'e', 't', 'C', 'o', 'n', 'f', 'i', 'g', 'R', '\026', 'd', 'o', 'w', 'n', 's', 't', 
'r', 'e', 'a', 'm', 'S', 'o', 'c', 'k', 'e', 't', 'C', 'o', 'n', 'f', 'i', 'g', '\022', 'P', '\n', '\014', 'q', 'u', 'i', 'c', '_', 
'o', 'p', 't', 'i', 'o', 'n', 's', '\030', '\007', ' ', '\001', '(', '\013', '2', '-', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 
'f', 'i', 'g', '.', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '.', 'v', '3', '.', 'Q', 'u', 'i', 'c', 'P', 'r', 'o', 't', 'o', 
'c', 'o', 'l', 'O', 'p', 't', 'i', 'o', 'n', 's', 'R', '\013', 'q', 'u', 'i', 'c', 'O', 'p', 't', 'i', 'o', 'n', 's', '\022', 'p', 
'\n', '\037', 'u', 'd', 'p', '_', 'p', 'a', 'c', 'k', 'e', 't', '_', 'p', 'a', 'c', 'k', 'e', 't', '_', 'w', 'r', 'i', 't', 'e', 
'r', '_', 'c', 'o', 'n', 'f', 'i', 'g', '\030', '\010', ' ', '\001', '(', '\013', '2', '*', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 
'n', 'f', 'i', 'g', '.', 'c', 'o', 'r', 'e', '.', 'v', '3', '.', 'T', 'y', 'p', 'e', 'd', 'E', 'x', 't', 'e', 'n', 's', 'i', 
'o', 'n', 'C', 'o', 'n', 'f', 'i', 'g', 'R', '\033', 'u', 'd', 'p', 'P', 'a', 'c', 'k', 'e', 't', 'P', 'a', 'c', 'k', 'e', 't', 
'W', 'r', 'i', 't', 'e', 'r', 'C', 'o', 'n', 'f', 'i', 'g', ':', '.', '\232', '\305', '\210', '\036', ')', '\n', '\'', 'e', 'n', 'v', 'o', 
'y', '.', 'a', 'p', 'i', '.', 'v', '2', '.', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '.', 'U', 'd', 'p', 'L', 'i', 's', 't', 
'e', 'n', 'e', 'r', 'C', 'o', 'n', 'f', 'i', 'g', 'J', '\004', '\010', '\001', '\020', '\002', 'J', '\004', '\010', '\002', '\020', '\003', 'J', '\004', '\010', 
'\003', '\020', '\004', 'J', '\004', '\010', '\004', '\020', '\005', 'J', '\004', '\010', '\006', '\020', '\007', 'R', '\006', 'c', 'o', 'n', 'f', 'i', 'g', '\"', 'U', 
'\n', '\032', 'A', 'c', 't', 'i', 'v', 'e', 'R', 'a', 'w', 'U', 'd', 'p', 'L', 'i', 's', 't', 'e', 'n', 'e', 'r', 'C', 'o', 'n', 
'f', 'i', 'g', ':', '7', '\232', '\305', '\210', '\036', '2', '\n', '0', 'e', 'n', 'v', 'o', 'y', '.', 'a', 'p', 'i', '.', 'v', '2', '.', 
'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '.', 'A', 'c', 't', 'i', 'v', 'e', 'R', 'a', 'w', 'U', 'd', 'p', 'L', 'i', 's', 't', 
'e', 'n', 'e', 'r', 'C', 'o', 'n', 'f', 'i', 'g', 'B', '\226', '\001', '\n', '&', 'i', 'o', '.', 'e', 'n', 'v', 'o', 'y', 'p', 'r', 
'o', 'x', 'y', '.', 'e', 'n', 'v', 'o', 'y', '.', 'c', 'o', 'n', 'f', 'i', 'g', '.', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', 
'.', 'v', '3', 'B', '\026', 'U', 'd', 'p', 'L', 'i', 's', 't', 'e', 'n', 'e', 'r', 'C', 'o', 'n', 'f', 'i', 'g', 'P', 'r', 'o', 
't', 'o', 'P', '\001', 'Z', 'J', 'g', 'i', 't', 'h', 'u', 'b', '.', 'c', 'o', 'm', '/', 'e', 'n', 'v', 'o', 'y', 'p', 'r', 'o', 
'x', 'y', '/', 'g', 'o', '-', 'c', 'o', 'n', 't', 'r', 'o', 'l', '-', 'p', 'l', 'a', 'n', 'e', '/', 'e', 'n', 'v', 'o', 'y', 
'/', 'c', 'o', 'n', 'f', 'i', 'g', '/', 'l', 'i', 's', 't', 'e', 'n', 'e', 'r', '/', 'v', '3', ';', 'l', 'i', 's', 't', 'e', 
'n', 'e', 'r', 'v', '3', '\272', '\200', '\310', '\321', '\006', '\002', '\020', '\002', 'b', '\006', 'p', 'r', 'o', 't', 'o', '3', 
};

static _upb_DefPool_Init *deps[6] = {
  &envoy_config_core_v3_extension_proto_upbdefinit,
  &envoy_config_core_v3_udp_socket_config_proto_upbdefinit,
  &envoy_config_listener_v3_quic_config_proto_upbdefinit,
  &udpa_annotations_status_proto_upbdefinit,
  &udpa_annotations_versioning_proto_upbdefinit,
  NULL
};

_upb_DefPool_Init envoy_config_listener_v3_udp_listener_config_proto_upbdefinit = {
  deps,
  &envoy_config_listener_v3_udp_listener_config_proto_upb_file_layout,
  "envoy/config/listener/v3/udp_listener_config.proto",
  UPB_STRINGVIEW_INIT(descriptor, 921)
};
