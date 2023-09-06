#!/bin/bash

sudo iptables -t filter -F #Flushing the filter table

sudo iptables -t filter -A INPUT -i lo -j ACCEPT
sudo iptables -t filter -A OUTPUT -o lo -j ACCEPT

sudo iptables -t filter -A INPUT -p icmp --icmp-type echo-request -m state --state NEW -j ACCEPT

sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT #ssh
sudo iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT

sudo iptables -A INPUT -m state --state INVALID -j DROP
sudo iptables -A OUTPUT -m state --state INVALID -j DROP

sudo iptables -A INPUT -p udp --sport 53 -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

sudo iptables -t filter -P INPUT DROP
sudo iptables -t filter -P OUTPUT DROP
