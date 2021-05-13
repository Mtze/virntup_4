# Virntup_4 
Virtualized Network Topologies using P4 

> This repository contains the P4 implementation for the [virntup (without the 4) project](https://github.com/Mtze/virntup). You can find more information about the project there. 

The P4 program in this repository allows to emulate many routers (vRouters) on a single P4 Target. Each vRouter can be assigned to each switch port and has its own routing table. 
The implementation is very basic as virntup is a proof of concept and is not meant for production use. 

You can find the P4Runtime client which is used to configure the tables automatically [here](https://github.com/Mtze/virntup).

# Program Design 

![Virntup_4_ingress](doc/img/virntup_4_ingress)

The P4 implementation is very straight forward. We first need to find out which vRouter should be consulted if a packet arrives on port x. Hence we apply the `vRouterNumberMatching` table. If we found a vRouter, we set the `vRouterNumber` for the current packet. If not we drop the packet. 

Next we apply the `ipv4NextHopLPM` table, which matches on the `vRouterNumber` and does LPM as usual. If the table conains a matching entry, we call the `ipv4Forwar` action, if not, we drop the packet. 

Thats it! Simple right?


