#!/usr/bin/env bash
# Pull the images still in use from the live WordPress site and drop them into
# images/ with the filenames this Quarto site expects. Run once, from the repo
# root, while the old site is still online. Requires curl.
#
#   bash scripts/fetch-wordpress-images.sh
#
# After it finishes, run scripts/optimize-images.sh to resize them.

set -euo pipefail
BASE="https://lab.devindrown.com/wp-content/uploads"
mkdir -p images/team images/research

get () { # get <remote-path> <local-path>
  if curl -fsSL "$BASE/$1" -o "$2"; then
    echo "  ok   $2"
  else
    echo "  MISS $2  (grab this one by hand)" >&2
  fi
}

echo "Team photos"
get 2020/07/Drown_headshot_bw.jpg        images/team/devin-drown.jpg
get 2023/08/BevynCover.jpg               images/team/bevyn-cover.jpg
get 2023/08/Upasana_Arora.jpeg           images/team/upasana-arora.jpg
get 2023/08/DWrenn-Headshot.jpg          images/team/danielle-wrenn.jpg
get 2020/07/Tracie_Haan.jpg              images/team/tracie-haan.jpg
get 2020/07/TaylorSeitz.jpg              images/team/taylor-seitz.jpg
get 2020/07/Jeremy_Buttler.jpg           images/team/jeremy-buttler.jpg
get 2020/07/Geneva-M.jpg                 images/team/geneva-mottet.jpg
get 2020/07/annelise-photo.jpg           images/team/anne-lise-ducluzeau.jpg

echo "Research images"
get 2020/06/DSCF0130.jpg                                  images/research/soil-microbiomes.jpg
get revslider/home-slider-10/slider10-c.png               images/research/pathogen-genomics.jpg
get 2023/11/LV-22-7005-41-1170x575.jpg                    images/research/sars-cov-2.jpg
get 2023/11/JR-19-6438-1-1170x575.jpg                     images/research/education.jpg
get 2020/07/research_migevo_qPNG.png                      images/research/evolutionary-modeling.png

echo "Other"
get 2020/07/DrownLab_silly_20160524-768x888-1.jpg         images/lab-group.jpg
get 2020/07/IMG_20160725_120131-768x875-1.jpg             images/mentoring.jpg
get 2023/11/Firefly-20231006094349_resize.png             images/home-hero.png

echo
echo "Missing from the live site: Ági Lehr and Bill Winnett had no photo."
echo "Add images/team/agi-lehr.jpg and images/team/bill-winnett.jpg yourself."
