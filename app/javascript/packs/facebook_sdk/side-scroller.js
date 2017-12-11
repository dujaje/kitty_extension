function sideScroller(current_group_count, current_user_id) {
  let avatars = document.querySelectorAll(".avatar-scroll");
  let description = document.querySelector(".side-scroller-description");
  avatars.forEach((avatar) => {
    avatar.addEventListener("click", () => {
      avatar.classList.toggle("avatar-highlighted");
      let membersArray = []
      avatars.forEach((avatar) => {
        if (avatar.classList.contains("avatar-highlighted")) {
          membersArray.push(avatar.dataset.id);
        }
      })
      console.log(membersArray)
      document.getElementById("involved_group_field").value = `${membersArray}`
      console.log(document.getElementById("involved_group_field").value)

      if (membersArray.length === current_group_count) {
        description.innerHTML = "";
        description.insertAdjacentHTML('afterbegin','<p><strong>Split equally</strong> between <strong>all members</strong> of the group</p>');
      }
      else if (membersArray.length > 2 && document.getElementById("involved_group_field").value.includes(current_user_id.to_s)) {
        const others_amount = membersArray.length - 1
        description.innerHTML = "";
        description.insertAdjacentHTML('afterbegin',`<p><strong>Split equally</strong> between <strong>you and ${others_amount} others</strong></p>`);
      }
      else if (membersArray.length === 1 && document.getElementById("involved_group_field").value.includes(current_user_id.to_s)) {
        const others_amount = membersArray.length - 1
        description.innerHTML = "";
        description.insertAdjacentHTML('afterbegin',`<p>You want to make an expense just with yourself? Even a cat doubts that...</p>`);
      }
      else if (document.getElementById("involved_group_field").value.includes(current_user_id.to_s)) {
        const others_amount = membersArray.length - 1
        description.innerHTML = "";
        description.insertAdjacentHTML('afterbegin',`<p><strong>Split equally</strong> between <strong>you and ${others_amount} other</strong></p>`);
      }
      else if (membersArray.length > 1) {
        const others_amount = membersArray.length
        description.innerHTML = "";
        description.insertAdjacentHTML('afterbegin',`<p><strong>You are owed everything</strong> by <strong>${others_amount} others</strong> who split it equally</p>`);
      }
      else if (membersArray.length === 1) {
        const others_amount = membersArray.length
        description.innerHTML = "";
        description.insertAdjacentHTML('afterbegin',`<p><strong>You are owed everything</strong> by just <strong>${others_amount} person</strong></p>`);
      }
      else {
        description.innerHTML = "";
        description.insertAdjacentHTML('afterbegin',`<p>Well this isn't going to work is it</p>`);
      }
    })
  })
}


export { sideScroller };
