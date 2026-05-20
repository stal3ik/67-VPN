#!/bin/bash
# Скрипт автоматического развертывания WireGuard

echo "Обновление системы и установка пакетов..."
apt update && apt install -y wireguard iptables resolvconf

echo "Включение IP Forwarding (Пункт 4 - Настройка маршрутизации)..."
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p

echo "Создание директории и генерация ключей сервера..."
mkdir -p /etc/wireguard
chmod 700 /etc/wireguard
wg genkey | tee /etc/wireguard/server_private | wg pubkey > /etc/wireguard/server_public

echo "Установка завершена!"
echo "Приватный ключ сервера:"
cat /etc/wireguard/server_private
