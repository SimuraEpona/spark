%{
  title: "Deploy Phoenix App to fly.io with custom domain",
  author: "Epona",
  tags: ~w(Elixir fly.io Phoenix Deploy),
  description: "this is a post about how to deploy phoenix app to fly.io and use custom donaim with SSL support.
"
}
---

this is a post about how to deploy phoenix app to fly.io and use custom donaim with SSL support.

when you need to deploy phoenix app to the world, there are lots of choices. I choose to use fly.io, because it's easy to use and free for small business.

## Deploy to Fly.io

this step is very easy, just follow [this guide](https://hexdocs.pm/phoenix/fly.html#what-we-ll-need), when you success deploy to fly.io you can visit your app through command `fly open`.

## Configure custom domain

although you can use `your-app-name.fly.dev` to visit your app, but it's nice to have your own domain. Let's do it.

### Change fly.toml config

replace `PHX_HOST` value to your custom domain

```
[env]
  PHX_HOST = "epona.me"
  PORT = "8080"
```

### Config A and AAAA Records

first, run `flyctl ips list` to see your app's addresses.

```
$ flyctl ips list
-------------------

TYPE   ADDRESS                                CREATED AT
  v4     77.83.143.105                          2020-03-02T14:59:13Z
  v6     2a09:8280:1:659f:6cb7:4925:6bfd:90a3   2020-03-02T14:59:13Z
```

next, Create an A record pointing to your v4 address, and an AAAA record pointing to your v6 address. 


### Adding the Certificate

```bash
flyctl certs create epona.me
```

### the important part

when you check certs there is likely an message like this below.

```bash
$ flyctl certs show epona.me

---------

The certificate for epona.me has not been issued yet.

Hostname                  = epona.me

DNS Provider              = cloudflare

Certificate Authority     = Let's Encrypt

Issued                    = 

Added to App              = 1 minute ago

Source                    = fly

Your certificate for epona.me is being issued. Status is Awaiting certificates. Make sure to create another certificate for www.epona.me when the current certificate is issued.

```

because our app can't handle HTTPS, so the error shows. we need to fix that.

in `config/prod.exs`, add these codes


```elixir
host = System.get_env("PHX_HOST") || "example.com"

config :spark, SparkWeb.Endpoint,
 url: [host: host, port: 443],
 force_ssl: [
   host: nil,
   rewrite_on: [:x_forwarded_port, :x_forwarded_proto],
   hsts: true
 ]
```

commit it and then deploy, now you can successfully visit your app with custom domain.


## References

- [Deploying on Fly.io](https://hexdocs.pm/phoenix/fly.html#content)
- [Using SSL](https://hexdocs.pm/phoenix/using_ssl.html)
