# VPC - Virtual Private Cloud

## What is a VPC?

Amazon Virtual Private Cloud (VPC) is a logically isolated network in an AWS region. You choose its IPv4 and optional IPv6 address ranges and control subnet placement, routing, and network traffic. A VPC spans Availability Zones; each subnet belongs to one Availability Zone.

## Core concepts

- **CIDR:** Classless Inter-Domain Routing notation describes an IP address range, such as `10.0.0.0/16`. Choose non-overlapping ranges that can be routed to connected networks; subnet ranges are carved from the VPC range.
- **Subnets:** Segments of a VPC IP range, each in one Availability Zone. They are not intrinsically public or private; route-table associations and attached gateways determine their connectivity.
- **Route tables:** Rules that direct traffic from a subnet or gateway to a destination, such as a local VPC range, internet gateway, NAT gateway, or VPN connection. Every subnet has an associated route table, explicitly or through the main table.
- **Internet Gateway (IGW):** A horizontally scaled VPC attachment that enables internet routing for eligible resources when routes and public addressing are configured. It does not by itself make every resource public.
- **NAT Gateway:** A managed service commonly used to let private-subnet resources initiate IPv4 connections to external destinations without accepting unsolicited internet connections. It is deployed in a subnet, usually public, and has availability and data-processing costs. It is not a general inbound gateway.
- **Security Groups:** Stateful, resource/network-interface-level firewalls that allow traffic. Return traffic for allowed connections is automatically allowed.
- **Network ACLs (NACLs):** Stateless subnet-level traffic filters with ordered allow and deny rules. Inbound and outbound rules are evaluated separately, so return traffic and ephemeral ports may need explicit rules.
- **Public vs private subnet:** A public subnet has a route to an IGW; instances generally also need a public IPv4 address or other public addressing to communicate directly with the internet. A private subnet has no direct route to an IGW. It may use a NAT gateway for outbound IPv4 connectivity. Private does not mean isolated from every network.

## Common design considerations

Plan CIDRs before connecting networks, distribute subnets across Availability Zones for resilience, keep application/data tiers private where possible, and use security groups as the primary workload firewall. Add NACL restrictions only when subnet-wide stateless controls are needed. Monitor NAT gateway and public IPv4 costs.

## Common use cases

- Separate public load balancers from private application and database tiers.
- Isolate development, testing, and production network environments.
- Connect VPCs to on-premises networks using supported VPN or dedicated connectivity.
- Control outbound access for private workloads through NAT or approved egress services.
