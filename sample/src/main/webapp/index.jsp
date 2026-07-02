<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Jenkins — Automate Everything You Ship</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@500;600;700&family=Inter:wght@400;500;600&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="style.css">
</head>
<body>

<header class="site-header">
  <nav class="nav">
    <a href="#home" class="brand" data-nav-link data-target="home"><span class="dot"></span> jenkins.local</a>
    <ul class="nav-links" id="navLinks">
      <li><a href="#home" data-nav-link data-target="home" class="active">Home</a></li>
      <li><a href="#features" data-nav-link data-target="features">Why Jenkins</a></li>
      <li><a href="#pipeline" data-nav-link data-target="pipeline">Pipeline</a></li>
    </ul>
    <button class="nav-toggle" id="navToggle" aria-label="Toggle menu">☰</button>
  </nav>
</header>

<main>

  <!-- ============ HOME ============ -->
  <section class="page" id="home" data-page>
    <section class="hero wrap">
      <div class="hero-grid">
        <div>
          <span class="eyebrow"><span class="dot"></span> Build #47 — passing</span>
          <h1>Push code.<br>Jenkins takes it <span class="accent">from there.</span></h1>
          <p>Jenkins is the open-source automation server that watches your repo, runs your build the moment you push, and tells you — pass or fail — before you've switched tabs.</p>
          <div class="hero-actions">
            <a href="#pipeline" class="btn btn-primary" data-nav-link data-target="pipeline">See a pipeline run →</a>
            <a href="#features" class="btn btn-ghost" data-nav-link data-target="features">Why teams use it</a>
          </div>
        </div>

        <div class="terminal reveal">
          <div class="terminal-bar">
            <span></span><span></span><span></span>
            <span class="t-label">build.log</span>
          </div>
          <div class="terminal-body" data-terminal></div>
        </div>
      </div>
    </section>

    <section class="section wrap">
      <div class="section-head reveal">
        <span class="eyebrow">01 — The idea</span>
        <h2>One push, zero manual steps.</h2>
        <p>Every commit is a question: does this still work? Jenkins answers it automatically, every time, so your team finds out in minutes, not at release day.</p>
      </div>

      <div class="card-grid">
        <div class="card reveal">
          <div class="icon">→</div>
          <h3>Detects the push</h3>
          <p>A webhook fires the instant you push to your branch — no manual trigger, no polling, no waiting around.</p>
        </div>
        <div class="card reveal">
          <div class="icon">⚙</div>
          <h3>Runs your pipeline</h3>
          <p>Checkout, build, test, deploy — defined once in a Jenkinsfile and executed the same way, every single time.</p>
        </div>
        <div class="card reveal">
          <div class="icon">✓</div>
          <h3>Reports back</h3>
          <p>Pass or fail, you get a clear result with full logs — before a broken build ever reaches production.</p>
        </div>
      </div>
    </section>
  </section>

  <!-- ============ FEATURES ============ -->
  <section class="page" id="features" data-page hidden>
    <section class="section wrap" style="padding-top: 64px;">
      <div class="section-head reveal">
        <span class="eyebrow"><span class="dot"></span> Why teams reach for it</span>
        <h2>Built for the part of shipping software nobody wants to do by hand.</h2>
        <p>Jenkins has stayed the backbone of CI/CD for over a decade because it doesn't force one workflow — it adapts to yours.</p>
      </div>

      <div class="card-grid">
        <div class="card reveal">
          <div class="icon">⬡</div>
          <h3>1,800+ plugins</h3>
          <p>GitHub, Docker, Slack, AWS, Kubernetes — if it's part of your stack, there's almost certainly a plugin for it.</p>
        </div>
        <div class="card reveal">
          <div class="icon">⌘</div>
          <h3>Pipeline as code</h3>
          <p>Your entire build process lives in a Jenkinsfile, versioned right alongside your source — no clicking through a UI to reconstruct it.</p>
        </div>
        <div class="card reveal">
          <div class="icon">⇄</div>
          <h3>Distributed builds</h3>
          <p>Spread work across multiple agents and machines so builds run in parallel instead of queuing up behind each other.</p>
        </div>
        <div class="card reveal">
          <div class="icon">🔒</div>
          <h3>Self-hosted control</h3>
          <p>Runs on your own infrastructure — your code, your secrets, and your build history never leave your servers.</p>
        </div>
        <div class="card reveal">
          <div class="icon">↻</div>
          <h3>Free and open source</h3>
          <p>No per-seat pricing or usage caps. Community-maintained, and it's been battle-tested since 2011.</p>
        </div>
        <div class="card reveal">
          <div class="icon">◧</div>
          <h3>Works with anything</h3>
          <p>Java, Python, Node, .NET, mobile, static sites — Jenkins doesn't care what you're building, only that it can run a script.</p>
        </div>
      </div>
    </section>

    <section class="section wrap">
      <div class="pipeline-stage reveal" style="text-align:center; padding: 56px 32px;">
        <span class="eyebrow"><span class="dot"></span> See it in motion</span>
        <h2 style="margin: 14px 0 12px;">Want to watch a build actually run?</h2>
        <p style="color: var(--text-muted); max-width: 50ch; margin: 0 auto 28px;">The pipeline tab walks through Checkout → Build → Test → Deploy — click one button and watch each stage complete live.</p>
        <a href="#pipeline" class="btn btn-primary" data-nav-link data-target="pipeline">Run the pipeline →</a>
      </div>
    </section>
  </section>

  <!-- ============ PIPELINE ============ -->
  <section class="page" id="pipeline" data-page hidden>
    <section class="section wrap" style="padding-top: 64px;">
      <div class="section-head reveal">
        <span class="eyebrow"><span class="dot"></span> How it works</span>
        <h2>Four stages. One click. Every push.</h2>
        <p>This is the same sequence Jenkins runs behind the scenes on every commit. Click below to watch it happen.</p>
      </div>

      <div class="pipeline-stage reveal">
        <div class="stepper">
          <div class="track-fill"></div>
          <div class="step">
            <div class="node">1</div>
            <div class="label">Checkout</div>
            <div class="sub">pull latest commit</div>
          </div>
          <div class="step">
            <div class="node">2</div>
            <div class="label">Build</div>
            <div class="sub">compile / bundle</div>
          </div>
          <div class="step">
            <div class="node">3</div>
            <div class="label">Test</div>
            <div class="sub">run test suite</div>
          </div>
          <div class="step">
            <div class="node">4</div>
            <div class="label">Deploy</div>
            <div class="sub">ship to production</div>
          </div>
        </div>

        <div class="status-line" data-status>Idle — click "Run Pipeline" to start a build</div>

        <div class="pipeline-controls">
          <button class="btn btn-primary" data-run-pipeline>▶ Run Pipeline</button>
          <button class="btn btn-ghost" data-reset-pipeline>Reset</button>
        </div>
      </div>
    </section>

    <section class="section wrap">
      <div class="section-head reveal">
        <span class="eyebrow">02 — In detail</span>
        <h2>What happens at each stage</h2>
      </div>

      <div class="reveal">
        <div class="timeline-item">
          <div class="timeline-num">01</div>
          <div>
            <h3>Checkout</h3>
            <p>Jenkins listens for a webhook from your repo host. The moment you push, it pulls the exact commit that triggered the build — nothing stale, nothing manual.</p>
          </div>
        </div>
        <div class="timeline-item">
          <div class="timeline-num">02</div>
          <div>
            <h3>Build</h3>
            <p>Your project is compiled, bundled, or otherwise prepared exactly as defined in the Jenkinsfile — the same steps a developer would run locally, just automated.</p>
          </div>
        </div>
        <div class="timeline-item">
          <div class="timeline-num">03</div>
          <div>
            <h3>Test</h3>
            <p>The test suite runs against the fresh build. If anything fails, the pipeline stops here and flags it — before it ever reaches deployment.</p>
          </div>
        </div>
        <div class="timeline-item">
          <div class="timeline-num">04</div>
          <div>
            <h3>Deploy</h3>
            <p>Once tests pass, the build ships — to a server, a container registry, or in this case, a static host. Fully automatic, fully logged.</p>
          </div>
        </div>
      </div>
    </section>
  </section>

</main>

<footer class="footer wrap">
  <div class="footer-inner">
    <span class="build-badge"><span class="dot"></span> deployed via Jenkins — build #47</span>
    <p>Single-page demo · built to show CI/CD in action</p>
  </div>
</footer>

<script src="script.js"></script>
</body>
</html>
