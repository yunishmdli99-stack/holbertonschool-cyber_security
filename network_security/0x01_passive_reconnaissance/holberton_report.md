# Shodan Reconnaissance Report — holbertonschool.com

**Date:** 2024  
**Target:** holbertonschool.com  
**Tool:** Shodan (https://www.shodan.io)  
**Method:** Passive Reconnaissance

---

## 1. IP Ranges

The following IP ranges were identified as associated with holbertonschool.com infrastructure:

| IP Address       | Provider         | Region        | Usage                        |
|------------------|------------------|---------------|------------------------------|
| 75.2.70.75       | Amazon AWS       | us-east-1     | Main domain (A record)       |
| 99.83.190.102    | Amazon AWS       | us-east-1     | Main domain (A record)       |
| 63.35.51.142     | Amazon AWS       | eu-west-1     | www, fr, webflow subdomains  |
| 13.36.10.99      | Amazon AWS       | eu-west-3     | apply.holbertonschool.com    |
| 13.37.98.87      | Amazon AWS       | eu-west-3     | read.holbertonschool.com     |
| 13.38.122.220    | Amazon AWS       | eu-west-3     | staging-apply-forum          |
| 13.38.216.13     | Amazon AWS       | eu-west-3     | lvl2-discourse-staging       |
| 18.66.196.8      | Amazon AWS       | eu-west-1     | staging-rails-assets-apply   |
| 34.203.198.145   | Amazon AWS       | us-east-1     | v2.holbertonschool.com       |
| 44.214.9.111     | Amazon AWS       | us-east-1     | beta.holbertonschool.com     |
| 52.47.143.83     | Amazon AWS       | eu-west-3     | yriry2.holbertonschool.com   |
| 52.85.96.82      | Amazon AWS       | us-east-1     | rails-assets (CloudFront)    |
| 52.85.96.95      | Amazon AWS       | us-east-1     | assets (CloudFront)          |
| 54.86.136.129    | Amazon AWS       | us-east-1     | v1.holbertonschool.com       |
| 54.89.246.137    | Amazon AWS       | us-east-1     | v3.holbertonschool.com       |
| 54.157.56.129    | Amazon AWS       | us-east-1     | alpha.holbertonschool.com    |
| 35.180.20.42     | Amazon AWS       | eu-west-3     | staging-apply                |
| 104.16.53.111    | Cloudflare       | Global CDN    | support.holbertonschool.com  |
| 151.139.128.10   | Fastly CDN       | Global CDN    | fr.webflow, en.fr subdomains |
| 192.0.78.131     | WordPress.com    | Global        | blog.holbertonschool.com     |

### IP Ranges Summary (CIDR Blocks)

| CIDR Block        | Provider              |
|-------------------|-----------------------|
| 75.2.0.0/16       | Amazon AWS Global Accelerator |
| 99.83.0.0/16      | Amazon AWS Global Accelerator |
| 13.36.0.0/14      | Amazon AWS eu-west-3  |
| 18.64.0.0/10      | Amazon AWS CloudFront |
| 34.192.0.0/10     | Amazon AWS us-east-1  |
| 44.192.0.0/10     | Amazon AWS us-east-1  |
| 52.0.0.0/8        | Amazon AWS us-east-1  |
| 54.0.0.0/8        | Amazon AWS us-east-1  |
| 104.16.0.0/12     | Cloudflare            |
| 151.139.128.0/17  | Fastly CDN            |
| 192.0.64.0/18     | Automattic/WordPress  |

---

## 2. Technologies and Frameworks

### 2.1 Web Servers

| Technology   | Subdomains                                      |
|--------------|-------------------------------------------------|
| Nginx        | apply, staging-apply, v1, v2, v3, alpha, beta   |
| Apache       | blog.holbertonschool.com                        |
| CloudFront   | assets, rails-assets (CDN layer)                |
| Cloudflare   | support.holbertonschool.com                     |

### 2.2 Frontend Frameworks

| Technology     | Evidence                                      |
|----------------|-----------------------------------------------|
| React.js       | apply.holbertonschool.com (SPA structure)     |
| Webflow        | webflow.holbertonschool.com, fr.webflow        |
| Ruby on Rails  | rails-assets subdomain, staging-rails-assets  |
| Bootstrap      | Detected in page assets                       |

### 2.3 Backend & Infrastructure

| Technology        | Evidence / Subdomain                        |
|-------------------|---------------------------------------------|
| Ruby on Rails     | rails-assets, staging-rails-assets subdomains |
| Discourse         | lvl2-discourse-staging.holbertonschool.com  |
| Zendesk           | support.holbertonschool.com (CNAME)         |
| WordPress         | blog.holbertonschool.com (192.0.78.x range) |

### 2.4 Cloud & CDN Services

| Service              | Usage                                     |
|----------------------|-------------------------------------------|
| Amazon AWS           | Primary infrastructure (EC2, CloudFront)  |
| AWS Global Accelerator | Main domain load balancing              |
| Cloudflare           | support subdomain DDoS protection & CDN   |
| Fastly               | fr.webflow and en.fr subdomains           |
| WordPress.com VIP    | Blog hosting                              |

### 2.5 Email & DNS Services

| Service       | Evidence (from TXT/MX records)                     |
|---------------|----------------------------------------------------|
| Google Workspace | MX records pointing to aspmx.l.google.com      |
| Mailgun       | SPF record includes mailgun.org                    |
| Zendesk       | SPF record includes mail.zendesk.com               |
| Mailchimp     | SPF record includes servers.mcsv.net               |
| Intacct       | SPF record includes _spf.intacct.com               |
| Exclaimer     | SPF record includes spf.exclaimer.net              |
| AWS Route 53  | NS records (ns-*.awsdns-*)                         |

### 2.6 Open Ports Detected (via Shodan)

| Port  | Protocol | Service          | Notable Subdomains             |
|-------|----------|------------------|--------------------------------|
| 80    | HTTP     | Web              | Most subdomains                |
| 443   | HTTPS    | Web (TLS)        | Most subdomains                |
| 8080  | HTTP-alt | Dev/Staging      | Staging subdomains             |
| 22    | SSH      | Secure Shell     | Some EC2 instances             |

### 2.7 SSL/TLS

| Detail         | Value                                      |
|----------------|--------------------------------------------|
| Certificate CA | Amazon / Let's Encrypt                     |
| TLS Versions   | TLS 1.2, TLS 1.3                           |
| Wildcard Cert  | *.holbertonschool.com                      |

---

## 3. Subdomains Discovered

| Subdomain                              | IP               | Technology          |
|----------------------------------------|------------------|---------------------|
| www.holbertonschool.com                | 63.35.51.142     | AWS / Webflow       |
| apply.holbertonschool.com              | 13.36.10.99      | Rails / React       |
| blog.holbertonschool.com               | 192.0.78.131     | WordPress           |
| support.holbertonschool.com            | 104.16.53.111    | Zendesk/Cloudflare  |
| fr.holbertonschool.com                 | 63.35.51.142     | Webflow             |
| webflow.holbertonschool.com            | 63.35.51.142     | Webflow             |
| fr.webflow.holbertonschool.com         | 151.139.128.10   | Webflow / Fastly    |
| en.fr.holbertonschool.com              | 151.139.128.10   | Webflow / Fastly    |
| assets.holbertonschool.com             | 52.85.96.95      | AWS CloudFront      |
| rails-assets.holbertonschool.com       | 52.85.96.82      | AWS CloudFront      |
| read.holbertonschool.com               | 13.37.98.87      | AWS EC2             |
| v1.holbertonschool.com                 | 54.86.136.129    | AWS EC2             |
| v2.holbertonschool.com                 | 34.203.198.145   | AWS EC2             |
| v3.holbertonschool.com                 | 54.89.246.137    | AWS EC2             |
| alpha.holbertonschool.com              | 54.157.56.129    | AWS EC2             |
| beta.holbertonschool.com               | 44.214.9.111     | AWS EC2             |
| staging-apply.holbertonschool.com      | 35.180.20.42     | Rails / Staging     |
| staging-apply-forum.holbertonschool.com| 13.38.122.220    | Discourse/Staging   |
| staging-rails-assets-apply             | 18.66.196.8      | AWS CloudFront      |
| lvl2-discourse-staging                 | 13.38.216.13     | Discourse           |
| yriry2.holbertonschool.com             | 52.47.143.83     | AWS EC2             |
| help.holbertonschool.com               | 75.2.70.75       | AWS                 |

---

## 4. Key Findings Summary

- **Primary Cloud Provider:** Amazon Web Services (AWS) — nearly all infrastructure is hosted on AWS across `us-east-1` and `eu-west-3` regions.
- **CDN:** Mix of AWS CloudFront, Cloudflare, and Fastly depending on subdomain.
- **Web Framework:** Ruby on Rails is the primary backend (evidenced by `rails-assets` subdomains and staging names).
- **Frontend:** Webflow is used for marketing pages; React likely used for the apply portal.
- **Email Stack:** Google Workspace for mail, Mailgun for transactional email, Mailchimp for newsletters, Zendesk for support tickets.
- **Staging Environment:** Multiple staging subdomains are exposed and publicly accessible, which could be an attack surface.
- **Discourse Forum:** A staging Discourse instance is exposed publicly.
- **DNS Provider:** AWS Route 53 (4 nameservers across different TLDs for redundancy).

---

## 5. Potential Security Observations

| Observation                          | Risk Level | Notes                                      |
|--------------------------------------|------------|--------------------------------------------|
| Exposed staging subdomains           | Medium     | May run older/unpatched versions           |
| Multiple legacy versioned subdomains | Low-Medium | v1, v2, v3 may be unpatched                |
| Discourse staging publicly accessible| Medium     | May expose vulnerabilities                 |
| Mixed CDN providers                  | Low        | Potential inconsistency in security config |

---

*This report was generated using passive reconnaissance techniques only. No direct interaction with target systems was performed.*
