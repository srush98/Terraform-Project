# File: modules/loadbalancer-9400/main.tf

resource "azurerm_lb" "lb" {
  name                = "${var.prefix}-LB"
  resource_group_name = var.resource_group_name
  location            = var.location

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.lb.id
  }

  tags = var.tags

}

resource "azurerm_public_ip" "lb" {
  name                = "${var.prefix}-PIP-LB"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  tags                = var.tags
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "backend-pool"
  loadbalancer_id = azurerm_lb.lb.id
}

resource "azurerm_network_interface_backend_address_pool_association" "linux" {
  count = 2
  network_interface_id    = var.linux_nic_ids[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
  ip_configuration_name   = "internal"
}

resource "azurerm_lb_rule" "rule" {
  name                           = "http-rule"
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip-config"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.probe.id
}

resource "azurerm_lb_probe" "probe" {
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "health-probe"
  port                = 80
  protocol            = "Http"
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}