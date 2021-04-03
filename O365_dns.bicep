param dnszones_name string = 'contoso.com'
param mxrecord1 string ='contoso-com.mail.protection.outlook.com.'
param autodiscover_cname string = 'autodiscover.outlook.com.'
param entreg_cname string = 'enterpriseregistration.windows.net.'
param entenrol_cname string = 'enterpriseenrollment.manage.microsoft.com.'
param spf_txt string = 'v=spf1 include:spf.protection.outlook.com -all'


resource dnszones_name_resource 'Microsoft.Network/dnszones@2018-05-01' = {
  name: dnszones_name
  location: 'global'
  properties: {
    zoneType: 'Public'
  }
}

resource Microsoft_Network_dnszones_NS 'Microsoft.Network/dnszones/NS@2018-05-01' = {
  name: '${dnszones_name_resource.name}/@'
  properties: {
    TTL: 172800
    NSRecords: [
      {
        nsdname: 'ns1-04.azure-dns.com.'
      }
      {
        nsdname: 'ns2-04.azure-dns.net.'
      }
      {
        nsdname: 'ns3-04.azure-dns.org.'
      }
      {
        nsdname: 'ns4-04.azure-dns.info.'
      }
    ]
    targetResource: {}
  }
}

resource Microsoft_Network_dnszones_SOA 'Microsoft.Network/dnszones/SOA@2018-05-01' = {
  name: '${dnszones_name_resource.name}/@'
  properties: {
    TTL: 3600
    SOARecord: {
      email: 'azuredns-hostmaster.microsoft.com'
      expireTime: 2419200
      host: 'ns1-04.azure-dns.com.'
      minimumTTL: 300
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
    targetResource: {}
  }
}

resource Microsoft_Network_dnszones_MX1 'Microsoft.Network/dnsZones/MX@2018-05-01' = {
  name: '${dnszones_name_resource.name}/@'
  properties: {
    TTL: 3600
    MXRecords: [
      {
        exchange: mxrecord1
        preference: 0
      }
    ]
    targetResource:{}
  }
}

resource Microsoft_Network_dnszones_autodiscover_cname 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  name: '${dnszones_name_resource.name}/autodiscover'
  properties: {
    TTL: 3600
    CNAMERecord:{
      cname: autodiscover_cname
    }    
    targetResource:{}
  }
}

resource Microsoft_Network_dnszones_entreg_cname 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  name: '${dnszones_name_resource.name}/enterpriseregistration'
  properties: {
    TTL: 3600
    CNAMERecord:{
      cname: entreg_cname
    }    
    targetResource:{}
  }
}

resource Microsoft_Network_dnszones_entenrol_cname 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  name: '${dnszones_name_resource.name}/enterpriseenrollment'
  properties: {
    TTL: 3600
    CNAMERecord:{
      cname: entenrol_cname
    }    
    targetResource:{}
  }
}

resource Microsoft_Network_dnszones_spf 'Microsoft.Network/dnsZones/TXT@2018-05-01' = {
  name:'${dnszones_name_resource.name}/@'
  properties: {
    TTL: 3600
    TXTRecords:[
      {
        value: [
          spf_txt
        ]
      }
    ]
    targetResource:{}
  }
}
