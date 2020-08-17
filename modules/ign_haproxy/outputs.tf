output "ign_haproxy_output" {
  value = data.ignition_config.lb.rendered
}

