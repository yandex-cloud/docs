```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
  namespace: nginx-demo
data:
  nginx.conf: |
    server {
      listen 80;

      root /usr/share/nginx/html;
      index index.html;

      ssi on;
      ssi_types text/html;
      ssi_last_modified on;

      location / {
        try_files $uri $uri/ =404;
      }

      location /nginx_status {
        stub_status;
        access_log off;
        allow 127.0.0.1;
        deny all;
      }
    }

  index.html: |
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="utf-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <title>Nginx Demo</title>
      <style>
        body { font-family: -apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Arial,sans-serif; background:#0b1020; color:#e6edf3; margin:0; }
        .wrap { max-width: 900px; margin: 80px auto; padding: 0 20px; }
        .card { background:#111a33; border:1px solid rgba(255,255,255,.08); border-radius: 16px; padding: 28px; box-shadow: 0 10px 30px rgba(0,0,0,.35); }
        h1 { margin:0 0 10px; font-size: 28px; }
        p { margin: 8px 0; color:#b7c3d0; }
        code { background: rgba(255,255,255,.06); padding: 2px 6px; border-radius: 8px; }
        .ok { display:inline-block; margin-top:14px; padding:8px 12px; border-radius: 999px; background: rgba(56,189,248,.12); border:1px solid rgba(56,189,248,.35); color:#7dd3fc; }
        .grid { display:grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-top: 18px; }
        .mini { background: rgba(255,255,255,.04); border:1px solid rgba(255,255,255,.06); border-radius: 14px; padding: 14px; }
        .mini b { color:#e6edf3; }
        @media (max-width: 700px) { .grid { grid-template-columns: 1fr; } }
      </style>
    </head>
    <body>
      <div class="wrap">
        <div class="card">
          <h1>🚀 Nginx is serving this page</h1>
          <p>This is a simple demo page served from a Kubernetes pod.</p>
          <div class="ok">Status: OK</div>

          <div class="grid">
            <div class="mini">
              <p><b>Endpoint:</b> <code>/</code></p>
              <p>Static HTML from <code>/usr/share/nginx/html/index.html</code></p>
            </div>
            <div class="mini">
              <p><b>Metrics:</b> <code>/metrics</code> (exporter)</p>
              <p>Nginx stub status: <code>/nginx_status</code> (localhost-only)</p>
            </div>
          </div>

          <!-- New grid section: runtime pod info -->
          <div class="grid" style="margin-top:18px;">
            <div class="mini">
              <p><b>Pod (hostname):</b></p>
              <p><code><!--# echo var="hostname" --></code></p>
            </div>
            <div class="mini">
              <p><b>Pod IP:</b></p>
              <p><code><!--# echo var="server_addr" --></code></p>
            </div>
            <div class="mini">
              <p><b>Client IP:</b></p>
              <p><code><!--# echo var="remote_addr" --></code></p>
            </div>
            <div class="mini">
              <p><b>Request time:</b></p>
              <p><code><!--# echo var="time_local" --></code></p>
            </div>
          </div>

          <p style="margin-top:18px;">
            Refresh the page to see load balancing between pods.
          </p>

          <p style="margin-top:18px;">
            If you see this page via LoadBalancer/Ingress — publishing works.
          </p>
        </div>
        
      </div>
    </body>
    </html>
```