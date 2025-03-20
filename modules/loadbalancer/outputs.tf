# File: modules/loadbalancer/outputs.tf

output "lb_name" {
  value = azurerm_lb.lb.name
}
