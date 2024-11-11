domain_name = "somedomain.com"
# This is the hosting domain.  This should be set up to point to a hosted zone in route53 with the same name asa the domain.  
# This plan will create a new A record in the hosted zone that points to the created cloud front distribution
domain_prefix = "devbarebones"
# This is the subdomain that will be added to the domain name to produce the domain for this web site.
common_tags = {
  Project = "Barebones project development version"
}
