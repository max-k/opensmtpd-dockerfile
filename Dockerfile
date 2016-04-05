FROM alpine:latest

MAINTAINER Thomas Sarboni <max-k@post.com>

RUN apk update && apk add opensmtpd

RUN cat > /etc/smtpd/smtpd.conf << EOF
# This is the smtpd server system-wide configuration file.
# See smtpd.conf(5) for more information.

# To accept external mail, replace with: listen on all
listen on 0.0.0.0

# If you edit the file, you have to run "smtpctl update table aliases"
table aliases file:/etc/smtpd/aliases

# Uncomment the following to accept external mail for domain "example.org"
#accept from any for domain "example.org" alias <aliases> deliver to mbox

#accept for local alias <aliases> deliver to mbox
accept from any for any relay
EOF

VOLUME /etc/smtpd /var/spool/mail

EXPOSE 25 587 ENTRYPOINT ["/usr/sbin/smtpd", "-d"]
