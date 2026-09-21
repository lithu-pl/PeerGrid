// PeerGrid Interactive Prototype Controller
document.addEventListener('DOMContentLoaded', () => {
  // Navigation handling
  function navigateTo(screenId) {
    const screens = document.querySelectorAll('.app-screen');
    screens.forEach(s => s.classList.remove('active'));

    const target = document.getElementById(`screen-${screenId}`);
    if (target) {
      target.classList.add('active');
      document.querySelector('.screen-viewport').scrollTop = 0;
    }

    // Update sidebar buttons
    document.querySelectorAll('.screen-btn').forEach(btn => {
      if (btn.dataset.screen === screenId) {
        btn.classList.add('active');
      } else {
        btn.classList.remove('active');
      }
    });

    // Update bottom bar home state
    const homeBtn = document.querySelector('.bottom-nav-bar .nav-icon-btn.nav-to[data-target="home"]');
    if (homeBtn) {
      if (screenId === 'home') {
        homeBtn.classList.add('active');
      } else {
        homeBtn.classList.remove('active');
      }
    }
  }

  // Bind all nav-to elements
  document.querySelectorAll('.nav-to').forEach(el => {
    el.addEventListener('click', (e) => {
      e.preventDefault();
      const target = el.dataset.target;
      if (target) navigateTo(target);
    });
  });

  // Sidebar screen jump buttons
  document.querySelectorAll('.screen-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const target = btn.dataset.screen;
      if (target) navigateTo(target);
    });
  });

  // Plus button in bottom nav
  const addBtn = document.getElementById('btn-nav-add');
  if (addBtn) {
    addBtn.addEventListener('click', () => {
      navigateTo('community');
      const input = document.getElementById('feed-post-text');
      if (input) input.focus();
    });
  }

  // Predictor button logic
  const predictBtn = document.getElementById('btn-run-predict');
  if (predictBtn) {
    predictBtn.addEventListener('click', () => {
      const rankInput = document.getElementById('pred-rank');
      const rank = parseInt(rankInput.value) || 15000;
      const resultsContainer = document.getElementById('prediction-results');

      predictBtn.textContent = 'Calculating...';
      predictBtn.disabled = true;

      setTimeout(() => {
        predictBtn.textContent = 'Predict';
        predictBtn.disabled = false;

        let html = '';
        if (rank <= 16000) {
          html = `
            <div class="predict-card">
              <div class="predict-details">
                <div class="predict-title-row">
                  <h5>College of Engineering Trivandrum</h5>
                  <span class="badge-high">High Chance</span>
                </div>
                <p class="score-line">Your Score: ${rank}</p>
                <p class="closing-line">Closing Rank: 18000</p>
              </div>
              <div class="predict-circle high">85%</div>
            </div>
            <div class="predict-card">
              <div class="predict-details">
                <div class="predict-title-row">
                  <h5>Model Engineering College</h5>
                  <span class="badge-mod">Moderate Chance</span>
                </div>
                <p class="score-line">Your Score: ${rank}</p>
                <p class="closing-line">Closing Rank: 14000</p>
              </div>
              <div class="predict-circle mod">50%</div>
            </div>
            <div class="predict-card">
              <div class="predict-details">
                <div class="predict-title-row">
                  <h5>Rajiv Gandhi Institute of Technology</h5>
                  <span class="badge-high">High Chance</span>
                </div>
                <p class="score-line">Your Score: ${rank}</p>
                <p class="closing-line">Closing Rank: 22000</p>
              </div>
              <div class="predict-circle high">92%</div>
            </div>
          `;
        } else {
          html = `
            <div class="predict-card">
              <div class="predict-details">
                <div class="predict-title-row">
                  <h5>Rajiv Gandhi Institute of Technology</h5>
                  <span class="badge-high">High Chance</span>
                </div>
                <p class="score-line">Your Score: ${rank}</p>
                <p class="closing-line">Closing Rank: ${Math.round(rank * 1.15)}</p>
              </div>
              <div class="predict-circle high">82%</div>
            </div>
            <div class="predict-card">
              <div class="predict-details">
                <div class="predict-title-row">
                  <h5>College of Engineering Poonjar</h5>
                  <span class="badge-high">High Chance</span>
                </div>
                <p class="score-line">Your Score: ${rank}</p>
                <p class="closing-line">Closing Rank: ${Math.round(rank * 1.35)}</p>
              </div>
              <div class="predict-circle high">95%</div>
            </div>
          `;
        }
        resultsContainer.innerHTML = html;
      }, 400);
    });
  }

  // Community Post creation
  const postBtn = document.getElementById('btn-submit-post');
  if (postBtn) {
    postBtn.addEventListener('click', () => {
      const textarea = document.getElementById('feed-post-text');
      const text = textarea.value.trim();
      if (!text) return;

      const feed = document.getElementById('posts-feed');
      const newCard = document.createElement('div');
      newCard.className = 'feed-card';
      newCard.innerHTML = `
        <div class="feed-author-row">
          <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200" alt="Lithu">
          <div>
            <h6>Lithu P L</h6>
            <span>College of Engineering Poonjar • Just now</span>
          </div>
        </div>
        <p class="feed-body">${escapeHTML(text)}</p>
        <div class="feed-reactions">
          <span class="reaction-btn" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> 0</span>
          <span class="reaction-btn"><i class="fa-regular fa-comment"></i> 0</span>
        </div>
      `;
      feed.prepend(newCard);
      textarea.value = '';
    });
  }
});

// Helper for escaping HTML
function escapeHTML(str) {
  return str.replace(/[&<>'"]/g, 
    tag => ({
      '&': '&amp;',
      '<': '&lt;',
      '>': '&gt;',
      "'": '&#39;',
      '"': '&quot;'
    }[tag] || tag)
  );
}

// Global actions for inline event handlers
function toggleRegister(btn, eventName) {
  if (btn.classList.contains('registered')) {
    btn.classList.remove('registered');
    btn.textContent = 'Register';
  } else {
    btn.classList.add('registered');
    btn.textContent = 'Registered';
  }
}

function toggleJoin(btn) {
  if (btn.classList.contains('joined')) {
    btn.classList.remove('joined');
    btn.textContent = 'Join';
  } else {
    btn.classList.add('joined');
    btn.textContent = 'Joined';
  }
}

function toggleLike(btn) {
  const icon = btn.querySelector('i');
  let count = parseInt(btn.textContent.trim()) || 0;
  if (icon.classList.contains('fa-solid')) {
    icon.classList.remove('fa-solid');
    icon.classList.add('fa-regular');
    btn.innerHTML = `<i class="fa-regular fa-thumbs-up"></i> ${Math.max(0, count - 1)}`;
  } else {
    icon.classList.remove('fa-regular');
    icon.classList.add('fa-solid');
    icon.style.color = '#00bcd4';
    btn.innerHTML = `<i class="fa-solid fa-thumbs-up" style="color: #00bcd4;"></i> ${count + 1}`;
  }
}

function openReviewModal() {
  const review = prompt('Enter your student review for College of Engineering Trivandrum:');
  if (review && review.trim()) {
    const list = document.querySelector('.reviews-list');
    const card = document.createElement('div');
    card.className = 'review-card';
    card.innerHTML = `
      <div class="review-header">
        <div class="reviewer-avatar">LP</div>
        <div class="reviewer-meta">
          <h6>Lithu P L</h6>
          <div class="stars">
            <i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>
          </div>
        </div>
      </div>
      <p class="review-text">${escapeHTML(review.trim())}</p>
      <div class="review-reactions">
        <span class="react-btn" onclick="toggleLike(this)"><i class="fa-regular fa-thumbs-up"></i> 0</span>
        <span class="react-btn"><i class="fa-regular fa-comment"></i> 0</span>
      </div>
    `;
    list.prepend(card);
  }
}
