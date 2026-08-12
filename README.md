# Drown Lab website

A Quarto static site for <https://lab.devindrown.com>. No database, no plugins,
no hosting bill. Content lives in plain Markdown files in this repository.

---

## The three things you asked to be easy

### 1. Add a publication

Paste a BibTeX entry anywhere in `refs.bib`. That is the whole task.

The publications page rebuilds itself from that file, sorted newest first.
Order inside the file does not matter. Get entries from Zotero, or from the
**Cite → BibTeX** link under any Google Scholar result.

To feature a paper on a research topic page, add its citation key to that
page's `nocite:` line. For example, in
`research/high-latitude-soil-microbiomes/index.qmd`:

```yaml
nocite: |
  @seitz2022unearthing, @seitz2021productivity, @haan2021resistance
```

One entry in `refs.bib` feeds the main list and every topic page that names it.
There is no second copy to keep in sync.

**Keeping it current with no manual export:** in Zotero, install Better BibTeX,
right-click your lab collection, choose *Export Collection*, tick *Keep
updated*, and point it at `refs.bib`. The file then updates whenever you add a
paper to Zotero.

### 2. Add or update a research topic

Create a folder under `research/` and put an `index.qmd` inside it. The folder
name becomes the URL. Copy an existing topic as your starting point.

```yaml
---
title: "Genetic Dark Matter in Active-Layer Soils"
description: "One or two sentences. This shows on the research index card."
image: /images/research/dark-matter.jpg
order: 6
categories: [Soil Microbiomes, Alaska]
nocite: |
  @somekey2026
---
```

The research index page picks it up automatically. `order` controls position.

### 3. Move a student to alumni

Open their file in `team/` and change one word:

```yaml
status: current     →     status: alumni
```

They move from *Current lab members* to *Former mentees* on the next build.
Nothing else needs editing. Adding a new person means copying an existing file
in `team/`, changing the front matter, and dropping a photo in `images/team/`.

---

## Editing without a terminal

Every file here is plain text. You can edit any of them in the GitHub web
interface: navigate to the file, click the pencil icon, commit. The site
rebuilds and redeploys itself within about two minutes.

Students can update their own bios by submitting a pull request, which is a
small useful skill for them and means you review changes rather than making
them.

---

## Local preview

Install [Quarto](https://quarto.org/docs/get-started/), then:

```bash
quarto preview       # live-reloading preview at localhost:4000
quarto render        # one-off build into _site/
```

You do not strictly need Quarto locally. GitHub Actions builds the site on every
push. Local preview just makes iteration faster.

---

## Deployment

`.github/workflows/publish.yml` renders the site and deploys to GitHub Pages on
every push to `main`. First-time setup:

1. Push this repository to GitHub.
2. **Settings → Pages → Source**, select **GitHub Actions**.
3. **Settings → Pages → Custom domain**, enter `lab.devindrown.com`.
4. At your DNS host, delete the existing `lab` record and add a CNAME:
   host `lab`, value `YOUR-USERNAME.github.io`.
5. Once GitHub's DNS check passes, tick **Enforce HTTPS**.

### The CNAME trap

Quarto wipes and rebuilds `_site/` on every render, which would delete the
`CNAME` file GitHub Pages needs, silently breaking your custom domain.

Two safeguards are already in place. `_quarto.yml` lists `CNAME` under
`project: resources:` so Quarto copies it into the output every build. And the
workflow asserts `_site/CNAME` exists, failing the deploy rather than shipping a
broken domain. Do not remove either one.

### URLs are preserved

Every path from the old WordPress site resolves at the same address, because the
folder structure mirrors it. Verified paths:

```
/research/high-latitude-soil-microbiomes/
/research/pathogen-genomics/
/research/sars-cov-2-genomic-epidemiology/
/research/education-and-outreach/
/research/evolutionary-modeling-of-spatially-structured-populations/
/our-team/   /team/<person>/   /lab-publications/
/teaching/   /contact/   /join-the-lab/
/mentoring-philosophy/   /collaborations/   /presentations/
```

Existing links and citations to your site keep working. Do not rename these
folders without a reason.

---

## Images

The site currently ships **placeholder images** in the site palette, so layout
is reviewable. Replace them with the real photos before going live:

```bash
bash scripts/fetch-wordpress-images.sh   # pull originals from the live WP site
bash scripts/optimize-images.sh          # resize and strip metadata
```

Run the fetch script while the old site is still online. Two people, Ági Lehr
and Bill Winnett, had no photo on WordPress, so add those by hand.

The optimize script needs ImageMagick (`brew install imagemagick`). The old site
served full-size uploads, some of them several megabytes.

---

## Still to do

- Replace placeholder images (above).
- `presentations/index.qmd` needs content ported from the old site.
- Fill in the short bios in `team/` for Upasana, Ági, Bill, and Geneva.
- Point the GitHub icon in `_quarto.yml` at your actual profile, or delete it.
- Optional: add `images/og-card.png` for link previews on social media.

---

## Layout

```
_quarto.yml          site config, navigation, theme
styles.scss          design system (palette, type, the horizon rule)
refs.bib             ALL publications. single source of truth.
apa.csl              APA 7th, patched to sort newest-first
CNAME                custom domain. do not delete.
index.qmd            home page
research/            one folder per topic, each with index.qmd
team/                one folder per person, each with index.qmd
our-team/            roster page, filters team/ by status
lab-publications/    renders refs.bib
scripts/             image migration helpers
.github/workflows/   build and deploy
```

## Design notes

Palette and type are drawn from a boreal soil profile rather than a generic
academic template. The four-band rule that repeats through the site (spruce,
ochre, grey, blue) is a soil horizon: organic mat, iron-stained active layer,
transition, permafrost table. Type is IBM Plex, with Serif for body text,
Condensed for headings, and Mono for labels and metadata, chosen to read as
scientific instrumentation rather than as a magazine.

To change the palette, edit the variables at the top of `styles.scss`. Every
color on the site derives from those six values.
